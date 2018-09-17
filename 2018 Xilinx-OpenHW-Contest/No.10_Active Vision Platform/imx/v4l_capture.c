// #include <sys/types.h>
// #include <sys/ioctl.h>
// #include <unistd.h>
// #include <fcntl.h>
// #include <stdio.h>
// #include <stdlib.h>
// #include <string.h>
// #include <sys/mman.h>
// #include <error.h>
// #include <errno.h>
// #include <linux/videodev2.h>

#include "dbg.h"
#include "myv4l.h"
#include "common.h"



int cap_fd = -1;
static int sizes_buf[MAX_CAPTURE_MODES][2];
struct capture_testbuffer cap_buffers[TEST_BUFFER_NUM];


static int getCaptureMode(int width, int height)
{
	int i, mode = -1;

	for (i = 0; i < MAX_CAPTURE_MODES; i++) {
		if (width == sizes_buf[i][0] &&
		    height == sizes_buf[i][1]) {
			mode = i;
			break;
		}
	}
	printf("mode = %d\n", mode);
	return mode;
}

int v4l_capture_setup(int width, int height, int fps)
{
	char v4l_device[80], node[8];
	struct v4l2_format fmt = {0};
	struct v4l2_streamparm parm = {0};
	struct v4l2_requestbuffers req = {0};
	struct v4l2_control ctl;
	struct v4l2_crop crop;
	struct v4l2_dbg_chip_ident chip;
	struct v4l2_frmsizeenum fsize;
	int i, g_input = 1, mode = 0;

	if (cap_fd > 0) {
		msg_warn("capture device already opened\n");
		return -1;
	}

	sprintf(node, "%d", 0); //change if not /dev/video1
	strcpy(v4l_device, "/dev/video");// whole name is /dev/video0
	strcat(v4l_device, node);

	if ((cap_fd = open(v4l_device, O_RDWR, 0)) < 0) {
		msg_err("Unable to open %s\n", v4l_device);
		return -1;
	}

	if (ioctl(cap_fd, VIDIOC_DBG_G_CHIP_IDENT, &chip)) {
		msg_err("VIDIOC_DBG_G_CHIP_IDENT failed.\n");
		return -1;
	}
	msg_info("sensor chip is %s\n", chip.match.name);

	memset(sizes_buf, 0, sizeof(sizes_buf));
	for (i = 0; i < MAX_CAPTURE_MODES; i++) {
		fsize.index = i;
		if (ioctl(cap_fd, VIDIOC_ENUM_FRAMESIZES, &fsize))
			break;
		else {
			sizes_buf[i][0] = fsize.discrete.width;
			sizes_buf[i][1] = fsize.discrete.height;
			printf("fsize.discrete.width = %d\n", fsize.discrete.width);
			printf("fsize.discrete.height = %d\n", fsize.discrete.height);
		}
	}
	
	ctl.id = V4L2_CID_PRIVATE_BASE;
	ctl.value = 1;
	if (ioctl(cap_fd, VIDIOC_S_CTRL, &ctl) < 0)
	{
		msg_err("set control failed\n");
		return -1;
	}

	mode = getCaptureMode(width, height);
	if (mode == -1) {
		msg_warn("Not support the resolution in camera\n");
		return -1;
	}
	msg_info("sensor frame size is %dx%d@%d\n", sizes_buf[mode][0],
					       sizes_buf[mode][1],fps);

	parm.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
	parm.parm.capture.timeperframe.numerator = 1;
	parm.parm.capture.timeperframe.denominator = fps;
	parm.parm.capture.capturemode = mode;
	if (ioctl(cap_fd, VIDIOC_S_PARM, &parm) < 0) {
		msg_err("set frame rate failed\n");
		close(cap_fd);
		cap_fd = -1;
		return -1;
	}

	if (ioctl(cap_fd, VIDIOC_G_PARM, &parm) < 0) {
		msg_err("set frame rate failed\n");
		close(cap_fd);
		cap_fd = -1;
		return -1;
	}

	msg_info("sensor frame size is %dx%d@%d\n", sizes_buf[mode][0],
					       sizes_buf[mode][1], parm.parm.capture.timeperframe.denominator);

	if (ioctl(cap_fd, VIDIOC_S_INPUT, &g_input) < 0) {
		msg_err("VIDIOC_S_INPUT failed\n");
		close(cap_fd);
		return -1;
	}

	// ctl.id = V4L2_CID_ROTATE;
	// ctl.value = 90;
	// printf("ctl.value = %d\n", ctl.value);
	// printf("ctl.id = %d\n", ctl.id);
 //    if (ioctl(cap_fd, VIDIOC_S_CTRL, &ctl) < 0)
 //    {
 //        printf("set rotate control failed\n");
 //        return -1;
 //    }

	crop.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
	crop.c.width = width;
	crop.c.height = height;
	crop.c.top = 0;
	crop.c.left = 0;
	// crop.c.width = stop_x - start_x;
	// crop.c.height = stop_y - start_y;
	// crop.c.top = start_y;
	// crop.c.left = start_x;

	if (ioctl(cap_fd, VIDIOC_S_CROP, &crop) < 0) {
		msg_warn("VIDIOC_S_CROP failed\n");
		close(cap_fd);
		return -1;
	}

	fmt.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
	fmt.fmt.pix.width = width;
	fmt.fmt.pix.height = height;
	fmt.fmt.pix.bytesperline =0 ;
	fmt.fmt.pix.priv = 0;
	fmt.fmt.pix.sizeimage = 0;
	fmt.fmt.pix.pixelformat = V4L2_PIX_FMT_YUV420;
	//fmt.fmt.pix.pixelformat = V4L2_PIX_FMT_GREY;
	if (ioctl(cap_fd, VIDIOC_S_FMT, &fmt) < 0) {
		msg_err("set format failed\n");
		close(cap_fd);
		return -1;
	}

	memset(&req, 0, sizeof(req));
	req.count = TEST_BUFFER_NUM;
	req.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
	req.memory = V4L2_MEMORY_MMAP;

	if (ioctl(cap_fd, VIDIOC_REQBUFS, &req) < 0) {
		msg_err("v4l_capture_setup: VIDIOC_REQBUFS failed\n");
		close(cap_fd);
		cap_fd = -1;
		return -1;
	}
	
	msg_info("device setup success\n");

	return 0;
}

int v4l_start_capturing(void)
{
	unsigned int i;
	struct v4l2_buffer buf;
	enum v4l2_buf_type type;

	for (i = 0; i < TEST_BUFFER_NUM; i++) {
		memset(&buf, 0, sizeof(buf));
		buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
		buf.memory = V4L2_MEMORY_MMAP;
		buf.index = i;
		if (ioctl(cap_fd, VIDIOC_QUERYBUF, &buf) < 0) {
			msg_err("VIDIOC_QUERYBUF error\n");
			return -1;
		}

		cap_buffers[i].length = buf.length;
		cap_buffers[i].offset = (size_t) buf.m.offset;
		cap_buffers[i].start =  mmap (NULL, /* start anywhere *///通过mmap建立映射关系
    					buf.length,
    					PROT_READ | PROT_WRITE /* required */,
    					MAP_SHARED /* recommended */,
    					cap_fd, buf.m.offset);
		if(MAP_FAILED==cap_buffers[i].start)
			msg_err("mmap failed");
	}

	for (i = 0; i < TEST_BUFFER_NUM; i++) {
		memset(&buf, 0, sizeof(buf));
		buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
		buf.memory = V4L2_MEMORY_MMAP;
		buf.index = i;
		buf.m.offset = cap_buffers[i].offset;
		if (ioctl(cap_fd, VIDIOC_QBUF, &buf) < 0) {
			msg_err("VIDIOC_QBUF error\n");
			return -1;
		}
	}

	type = 1;
	if (ioctl(cap_fd, VIDIOC_S_INPUT, &type) < 0) {
		msg_err("VIDIOC_STREAMON error\n");
		return -1;
	}

	type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
	if (ioctl(cap_fd, VIDIOC_STREAMON, &type) < 0) {
		msg_err("VIDIOC_STREAMON error\n");
		return -1;
	}
	msg_info("device start capturing\n");
	return 0;
}


void* v4l_get_capture_data(struct v4l2_buffer *buf)
{
	//memset(buf, 0, sizeof(struct v4l2_buffer));
	buf->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
	buf->memory = V4L2_MEMORY_MMAP;
	if (ioctl(cap_fd, VIDIOC_DQBUF, buf) < 0) {
		printf("errno = %d\n",errno);
		msg_err("VIDIOC_DQBUF failed\n");
		return NULL;
	}

	return cap_buffers[buf->index].start;
}


void v4l_put_capture_data(struct v4l2_buffer *buf)
{
	ioctl(cap_fd, VIDIOC_QBUF, buf);
}

void v4l_stop()
{
	int type;
	type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
	if (ioctl(cap_fd, VIDIOC_STREAMOFF, &type) < 0) {
		msg_err("VIDIOC_STREAMOFF error\n");
		return ;
	}
}



