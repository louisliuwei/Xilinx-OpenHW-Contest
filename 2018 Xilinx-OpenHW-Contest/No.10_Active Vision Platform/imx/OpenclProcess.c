#include "OpenclProcess.h"
//

// OpenCL source code

const char* OpenCLBinarySource[] = {

"__kernel void VectorBinary(__global uchar* c, __global uchar* a,__global uchar* b)",

"{",

" // Index of the elements to add \n",

" unsigned int n = get_global_id(0);",

" // Sum the nth element of vectors a and b and store in c \n",

" c[n] = a[n] > b[n] ? 1 : 0;",

"}"

};

const char* OpenCLBinarySource2[] = {

"__kernel void VectorBinary(__global uchar* c, __global uchar* a,__global uchar* b)",

"{",

" // Index of the elements to add \n",

" unsigned int n = get_global_id(0);",

" // Sum the nth element of vectors a and b and store in c \n",

" c[n] = a[n] > b[n] ? 1 : 0;",

"}"

};

const char* OpenCLBinarySource3[] = {

"__kernel void VectorBinary(__global uchar* c, __global uchar* a,__global uchar* b)",

"{",

" // Index of the elements to add \n",

" unsigned int n = get_global_id(0);",

" // Sum the nth element of vectors a and b and store in c \n",

" c[n] = a[n] > b[n] ? 1 : 0;",

"}"

};



void GPU_Init()
{

}
// Main function

// ************************************************************
void GPU_BinaryProcess(unsigned char* imageDataWhite, unsigned char* imageDataBlack, unsigned char* imageDataBinary)
{
     cl_platform_id cpPlatform;
     cl_device_id cdDevice;
     char cBuffer[100];
     cl_context GPUContext;
     cl_command_queue cqCommandQueue;
     cl_program OpenCLProgram;
     cl_kernel OpenCLVectorBinary;

     cl_mem GPUVector1;
     cl_mem GPUVector2;
     cl_mem GPUOutputVector;
          //Get an OpenCL platform
     clGetPlatformIDs(1, &cpPlatform, NULL);

     // Get a GPU device
     clGetDeviceIDs(cpPlatform, CL_DEVICE_TYPE_GPU, 1, &cdDevice, NULL);
     memset(cBuffer, 0, 100);
     clGetDeviceInfo(cdDevice, CL_DEVICE_NAME, sizeof(cBuffer), &cBuffer, NULL);
     //printf("CL_DEVICE_NAME: %s\n", cBuffer);

     // Create a context to run OpenCL enabled GPU
     clGetDeviceInfo(cdDevice, CL_DRIVER_VERSION, sizeof(cBuffer), &cBuffer, NULL);
     //printf("CL_DRIVER_VERSION: %s\n\n", cBuffer);
     GPUContext = clCreateContextFromType(0, CL_DEVICE_TYPE_GPU, NULL, NULL, NULL);

     // Create a command-queue on the GPU device
     cqCommandQueue = clCreateCommandQueue(GPUContext, cdDevice, 0, NULL);

     // Create OpenCL program with source code
     OpenCLProgram = clCreateProgramWithSource(GPUContext, 7, OpenCLBinarySource, NULL, NULL);

     // Build the program (OpenCL JIT compilation)
     clBuildProgram(OpenCLProgram, 0, NULL, NULL, NULL, NULL);

     // Create a handle to the compiled OpenCL function (Kernel)
     OpenCLVectorBinary = clCreateKernel(OpenCLProgram, "VectorBinary", NULL);
     // Allocate GPU memory for source vectors AND initialize from CPU memory
     cl_mem GPUVector1 = clCreateBuffer(GPUContext, CL_MEM_READ_WRITE | CL_MEM_COPY_HOST_PTR, sizeof(char) * SIZE, imageDataWhite, NULL);
     cl_mem GPUVector2 = clCreateBuffer(GPUContext, CL_MEM_READ_WRITE | CL_MEM_COPY_HOST_PTR, sizeof(char) * SIZE, imageDataBlack, NULL);

     // Allocate output memory on GPU
     cl_mem GPUOutputVector = clCreateBuffer(GPUContext, CL_MEM_READ_WRITE, sizeof(char) * SIZE, NULL, NULL);

     // In the next step we associate the GPU memory with the Kernel arguments
     clSetKernelArg(OpenCLVectorBinary, 0, sizeof(cl_mem), (void*)&GPUOutputVector);
     clSetKernelArg(OpenCLVectorBinary, 1, sizeof(cl_mem), (void*)&GPUVector1);
     clSetKernelArg(OpenCLVectorBinary, 2, sizeof(cl_mem), (void*)&GPUVector2);

     // Launch the Kernel on the GPU
     // This kernel only uses global data
     size_t WorkSize[1] = {SIZE}; // one dimensional Range
     clEnqueueNDRangeKernel(cqCommandQueue, OpenCLVectorBinary, 1, NULL, WorkSize, NULL, 0, NULL, NULL);

     // Copy the output in GPU memory back to CPU memory
     clEnqueueReadBuffer(cqCommandQueue, GPUOutputVector, CL_TRUE, 0, SIZE * sizeof(char), imageDataBinary, 0, NULL, NULL);

      // Cleanup
     clReleaseKernel(OpenCLVectorBinary);

     //clReleaseKernel(OpenCLVectorDecode);
     clReleaseProgram(OpenCLProgram);
     clReleaseCommandQueue(cqCommandQueue);
     clReleaseContext(GPUContext);
     clReleaseMemObject(GPUVector1);
     clReleaseMemObject(GPUVector2);
     clReleaseMemObject(GPUOutputVector);
}

void GPU_Deinit()
{
     
}

void GPU_BinaryProcess2(unsigned char* imageDataWhite, unsigned char* imageDataBlack, unsigned char* imageDataBinary)
{
     cl_platform_id cpPlatform;
     cl_device_id cdDevice;
     char cBuffer[100];
     cl_context GPUContext;
     cl_command_queue cqCommandQueue;
     cl_program OpenCLProgram;
     cl_kernel OpenCLVectorBinary;

     cl_mem GPUVector1;
     cl_mem GPUVector2;
     cl_mem GPUOutputVector;
          //Get an OpenCL platform
     clGetPlatformIDs(1, &cpPlatform, NULL);

     // Get a GPU device
     clGetDeviceIDs(cpPlatform, CL_DEVICE_TYPE_GPU, 1, &cdDevice, NULL);
     memset(cBuffer, 0, 100);
     clGetDeviceInfo(cdDevice, CL_DEVICE_NAME, sizeof(cBuffer), &cBuffer, NULL);
     //printf("CL_DEVICE_NAME: %s\n", cBuffer);

     // Create a context to run OpenCL enabled GPU
     clGetDeviceInfo(cdDevice, CL_DRIVER_VERSION, sizeof(cBuffer), &cBuffer, NULL);
     //printf("CL_DRIVER_VERSION: %s\n\n", cBuffer);
     GPUContext = clCreateContextFromType(0, CL_DEVICE_TYPE_GPU, NULL, NULL, NULL);

     // Create a command-queue on the GPU device
     cqCommandQueue = clCreateCommandQueue(GPUContext, cdDevice, 0, NULL);

     // Create OpenCL program with source code
     OpenCLProgram = clCreateProgramWithSource(GPUContext, 7, OpenCLBinarySource2, NULL, NULL);

     // Build the program (OpenCL JIT compilation)
     clBuildProgram(OpenCLProgram, 0, NULL, NULL, NULL, NULL);

     // Create a handle to the compiled OpenCL function (Kernel)
     OpenCLVectorBinary = clCreateKernel(OpenCLProgram, "VectorBinary", NULL);
     // Allocate GPU memory for source vectors AND initialize from CPU memory
     cl_mem GPUVector1 = clCreateBuffer(GPUContext, CL_MEM_READ_WRITE | CL_MEM_COPY_HOST_PTR, sizeof(char) * SIZE, imageDataWhite, NULL);
     cl_mem GPUVector2 = clCreateBuffer(GPUContext, CL_MEM_READ_WRITE | CL_MEM_COPY_HOST_PTR, sizeof(char) * SIZE, imageDataBlack, NULL);

     // Allocate output memory on GPU
     cl_mem GPUOutputVector = clCreateBuffer(GPUContext, CL_MEM_READ_WRITE, sizeof(char) * SIZE, NULL, NULL);

     // In the next step we associate the GPU memory with the Kernel arguments
     clSetKernelArg(OpenCLVectorBinary, 0, sizeof(cl_mem), (void*)&GPUOutputVector);
     clSetKernelArg(OpenCLVectorBinary, 1, sizeof(cl_mem), (void*)&GPUVector1);
     clSetKernelArg(OpenCLVectorBinary, 2, sizeof(cl_mem), (void*)&GPUVector2);

     // Launch the Kernel on the GPU
     // This kernel only uses global data
     size_t WorkSize[1] = {SIZE}; // one dimensional Range
     clEnqueueNDRangeKernel(cqCommandQueue, OpenCLVectorBinary, 1, NULL, WorkSize, NULL, 0, NULL, NULL);

     // Copy the output in GPU memory back to CPU memory
     clEnqueueReadBuffer(cqCommandQueue, GPUOutputVector, CL_TRUE, 0, SIZE * sizeof(char), imageDataBinary, 0, NULL, NULL);

      // Cleanup
     clReleaseKernel(OpenCLVectorBinary);

     //clReleaseKernel(OpenCLVectorDecode);
     clReleaseProgram(OpenCLProgram);
     clReleaseCommandQueue(cqCommandQueue);
     clReleaseContext(GPUContext);
     clReleaseMemObject(GPUVector1);
     clReleaseMemObject(GPUVector2);
     clReleaseMemObject(GPUOutputVector);
}

void GPU_BinaryProcess3(unsigned char* imageDataWhite, unsigned char* imageDataBlack, unsigned char* imageDataBinary)
{
     cl_platform_id cpPlatform;
     cl_device_id cdDevice;
     char cBuffer[100];
     cl_context GPUContext;
     cl_command_queue cqCommandQueue;
     cl_program OpenCLProgram;
     cl_kernel OpenCLVectorBinary;

     cl_mem GPUVector1;
     cl_mem GPUVector2;
     cl_mem GPUOutputVector;
          //Get an OpenCL platform
     clGetPlatformIDs(1, &cpPlatform, NULL);

     // Get a GPU device
     clGetDeviceIDs(cpPlatform, CL_DEVICE_TYPE_GPU, 1, &cdDevice, NULL);
     memset(cBuffer, 0, 100);
     clGetDeviceInfo(cdDevice, CL_DEVICE_NAME, sizeof(cBuffer), &cBuffer, NULL);
     //printf("CL_DEVICE_NAME: %s\n", cBuffer);

     // Create a context to run OpenCL enabled GPU
     clGetDeviceInfo(cdDevice, CL_DRIVER_VERSION, sizeof(cBuffer), &cBuffer, NULL);
     //printf("CL_DRIVER_VERSION: %s\n\n", cBuffer);
     GPUContext = clCreateContextFromType(0, CL_DEVICE_TYPE_GPU, NULL, NULL, NULL);

     // Create a command-queue on the GPU device
     cqCommandQueue = clCreateCommandQueue(GPUContext, cdDevice, 0, NULL);

     // Create OpenCL program with source code
     OpenCLProgram = clCreateProgramWithSource(GPUContext, 7, OpenCLBinarySource3, NULL, NULL);

     // Build the program (OpenCL JIT compilation)
     clBuildProgram(OpenCLProgram, 0, NULL, NULL, NULL, NULL);

     // Create a handle to the compiled OpenCL function (Kernel)
     OpenCLVectorBinary = clCreateKernel(OpenCLProgram, "VectorBinary", NULL);
     // Allocate GPU memory for source vectors AND initialize from CPU memory
     cl_mem GPUVector1 = clCreateBuffer(GPUContext, CL_MEM_READ_WRITE | CL_MEM_COPY_HOST_PTR, sizeof(char) * SIZE, imageDataWhite, NULL);
     cl_mem GPUVector2 = clCreateBuffer(GPUContext, CL_MEM_READ_WRITE | CL_MEM_COPY_HOST_PTR, sizeof(char) * SIZE, imageDataBlack, NULL);

     // Allocate output memory on GPU
     cl_mem GPUOutputVector = clCreateBuffer(GPUContext, CL_MEM_READ_WRITE, sizeof(char) * SIZE, NULL, NULL);

     // In the next step we associate the GPU memory with the Kernel arguments
     clSetKernelArg(OpenCLVectorBinary, 0, sizeof(cl_mem), (void*)&GPUOutputVector);
     clSetKernelArg(OpenCLVectorBinary, 1, sizeof(cl_mem), (void*)&GPUVector1);
     clSetKernelArg(OpenCLVectorBinary, 2, sizeof(cl_mem), (void*)&GPUVector2);

     // Launch the Kernel on the GPU
     // This kernel only uses global data
     size_t WorkSize[1] = {SIZE}; // one dimensional Range
     clEnqueueNDRangeKernel(cqCommandQueue, OpenCLVectorBinary, 1, NULL, WorkSize, NULL, 0, NULL, NULL);

     // Copy the output in GPU memory back to CPU memory
     clEnqueueReadBuffer(cqCommandQueue, GPUOutputVector, CL_TRUE, 0, SIZE * sizeof(char), imageDataBinary, 0, NULL, NULL);

      // Cleanup
     clReleaseKernel(OpenCLVectorBinary);

     //clReleaseKernel(OpenCLVectorDecode);
     clReleaseProgram(OpenCLProgram);
     clReleaseCommandQueue(cqCommandQueue);
     clReleaseContext(GPUContext);
     clReleaseMemObject(GPUVector1);
     clReleaseMemObject(GPUVector2);
     clReleaseMemObject(GPUOutputVector);
}



