#ifndef _TOP_H_
#define _TOP_H_
#include "hls_video.h"
#define MAX_WIDTH 1920
#define MAX_HEIGHT 1080

typedef hls::stream<ap_axiu<32,1,1,1> > AXI_STREAM_IN;
typedef hls::stream<ap_axiu<8,1,1,1> > AXI_STREAM_OUT;
typedef hls::Mat<MAX_HEIGHT, MAX_WIDTH, HLS_8UC3>  RGB_IMAGE;
typedef hls::Mat<MAX_HEIGHT, MAX_WIDTH, HLS_8UC1> GRAY_IMAGE;

void movedetection(AXI_STREAM_IN& input0_axi,AXI_STREAM_IN& input1_axi, AXI_STREAM_OUT& output_axi,int rows,int cols,int TH);

#endif
