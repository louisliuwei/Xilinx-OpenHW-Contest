#include "top.h"
void movedetection(AXI_STREAM_IN& input0, AXI_STREAM_IN& input1,AXI_STREAM_OUT& output,int rows,int cols,int TH) {

#pragma HLS INTERFACE axis port=input0
#pragma HLS INTERFACE axis port=input1
#pragma HLS INTERFACE axis port=output


#pragma HLS INTERFACE ap_none port=cols
#pragma HLS INTERFACE ap_none port=rows

#pragma HLS interface ap_ctrl_none port=return

	RGB_IMAGE framePre(rows, cols);//上一帧
	RGB_IMAGE frameNow(rows, cols);//当前帧
	RGB_IMAGE out(rows, cols);
	GRAY_IMAGE framePre_gray(rows, cols);
	GRAY_IMAGE frameNow_gray(rows, cols);

	GRAY_IMAGE Det1(rows, cols);
	GRAY_IMAGE Det2(rows, cols);
	GRAY_IMAGE Det3(rows, cols);
	GRAY_IMAGE Det4(rows, cols);
	GRAY_IMAGE temp2_pre(rows, cols);
	GRAY_IMAGE temp2_cur(rows, cols);

    #pragma HLS DATAFLOW // must use data flow to stream the data

	hls::AXIvideo2Mat(input0, framePre);
	hls::AXIvideo2Mat(input1, frameNow);

    hls::CvtColor<HLS_BGR2GRAY>(framePre,framePre_gray);//转灰度
	hls::CvtColor<HLS_BGR2GRAY>(frameNow,frameNow_gray);
	hls::GaussianBlur<3,3>( framePre_gray, temp2_pre );//高斯滤波
	hls::GaussianBlur<3,3>( frameNow_gray, temp2_cur );

	hls::AbsDiff(temp2_pre,temp2_cur,Det1);
    hls::Threshold(Det1,Det2,TH,255,HLS_THRESH_BINARY);//二值化
    hls::Erode(Det2,Det3);//腐蚀
    hls::Dilate(Det3,Det4);//膨胀
    hls::Mat2AXIvideo(Det4, output); //write the frames to video stream

}
