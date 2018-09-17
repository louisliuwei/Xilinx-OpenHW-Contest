#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <errno.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <termios.h>
#include <stdlib.h>
#include "../../common/common.h"
#include <sys/time.h>

char* makeJSON(char* tokenStr);

int main()
{	
	struct timeval t1;
	int i, j, k;
	char* input = (char*)calloc(100, sizeof(char));
    char* method;
    char* uri;

    char* zErrMsg = 0;

    printf("Content-type:text/html\n\n");

    // //output image
    FILE *pFilein, *pFileout;

    

    unsigned char *imageData = (unsigned char*)calloc(960 * 620 * 3 / 2, sizeof(unsigned char));
    memset(imageData, 128, 960 * 620 * 3 / 2);


    
    
	// unsigned short* imageDistortion;	    
	// imageDistortion = (unsigned short*)calloc(450 * 500, sizeof(unsigned short));
	// unsigned char* imageDistortionToHTML;	    
	// imageDistortionToHTML = (unsigned char*)calloc(450 * 500 * 2 + 1, sizeof(unsigned char));
	
    
    //Get request method
    method = getenv("REQUEST_METHOD");    
    //Get request uri  
    uri = getenv("REQUEST_URI");
    //Get request content which should be a jSON string
    input = getCgiData(stdin, method);      


    int shmid;
	char* shareMemory;
	char* ptr = "hello";

	shmid = shmget(0x90, 10, SHM_W | SHM_R | IPC_EXCL);

	if(shmid == -1){
		printf("cannot create share memory\n");
		return 0;
	}

	shareMemory = shmat(shmid, 0, 0);

	if(shareMemory == (void*)-1){
		printf("cannot get share memory\n");
		return 0;
	}

	if(strcmp(input, "1") == 0){
		memset(shareMemory, 0, 10);
		ptr = "test";
		strcpy(shareMemory, ptr);
		
		if((pFilein = fopen("/work/_Image/test.yuv","r")) == NULL){
	            printf("Cannot open test.yuv!\n");
	            return 0;
	    }
	    if((pFileout = fopen("/work/_Image/vputest.yuv","w")) == NULL){
		            printf("Cannot open test.yuv!\n");
		            return 0;
	    }

	    fseek(pFilein, 960 * 620 * 10, SEEK_SET);
	    fread(imageData, 1, 960*620, pFilein);
	    fwrite(imageData, 1, 960 * 620 * 3 / 2, pFileout);
	    fclose(pFilein);
	    fclose(pFileout);
	    free(imageData);

		while((strcmp(shareMemory, "done") != 0));
		memset(shareMemory, 0, 10);
		system("./mxc_vpu_test.out -E \"-i /work/_Image/vputest.yuv -w 960 -h 620 -o /var/www/_Image/vputest.jpg -f 7\"");
		//system("scp -i ~/.ssh/id_rsa /work/_Image/vputest.jpg root@192.168.10.10:/mnt/hgfs/share/image/_Image");
		gettimeofday(&t1, NULL);
        printf("%d\n",(int)t1.tv_usec % 1000);
	}
	if(strcmp(input, "2") == 0){
		memset(shareMemory, 0, 10);
		ptr = "calib";
		strcpy(shareMemory, ptr);
		//printf("set shareMemroy to calib done\n");

		if((pFilein = fopen("/work/_Image/background.yuv","r")) == NULL){
	            printf("Cannot open test.yuv!\n");
	            return 0;
	    }
	    if((pFileout = fopen("/work/_Image/vputest.yuv","w")) == NULL){
		            printf("Cannot open test.yuv!\n");
		            return 0;
	    }

	    fseek(pFilein, 960 * 620 * 10, SEEK_SET);
	    fread(imageData, 1, 960*620, pFilein);
	    fwrite(imageData, 1, 960 * 620 * 3 / 2, pFileout);
	    fclose(pFilein);
	    fclose(pFileout);
	    free(imageData);

		while((strcmp(shareMemory, "done") != 0));
		memset(shareMemory, 0, 10);
		system("./mxc_vpu_test.out -E \"-i /work/_Image/vputest.yuv -w 960 -h 620 -o /var/www/_Image/vputest.jpg -f 7\"");
		gettimeofday(&t1, NULL);
        printf("%d\n",(int)t1.tv_usec % 1000);
	}
	if(strcmp(input, "3") == 0){
		memset(shareMemory, 0, 10);
		ptr = "3DCaptureVH";
		strcpy(shareMemory, ptr);
		printf("set shareMemroy to 3DCaptureVH done\n");
	}
	if(strcmp(input, "4") == 0){
		memset(shareMemory, 0, 10);
		ptr = "3DCaptureV";
		strcpy(shareMemory, ptr);
		printf("set shareMemroy to 3DCaptureV done\n");
	}
	if(strcmp(input, "5") == 0){
		memset(shareMemory, 0, 10);
		ptr = "3DCaptureH";
		strcpy(shareMemory, ptr);
		printf("set shareMemroy to 3DCaptureH done\n");
	}
	if(strcmp(input, "6") == 0){
		memset(shareMemory, 0, 10);
		ptr = "SingleCap";
		strcpy(shareMemory, ptr);
		//printf("set shareMemroy to SingleCap done\n");

		if((pFilein = fopen("/work/_Image/object.yuv","r")) == NULL){
	            printf("Cannot open test.yuv!\n");
	            return 0;
	    }
	    if((pFileout = fopen("/work/_Image/vputest.yuv","w")) == NULL){
		            printf("Cannot open test.yuv!\n");
		            return 0;
	    }

	    fread(imageData, 1, 960*620, pFilein);
	    fwrite(imageData, 1, 960 * 620 * 3 / 2, pFileout);
	    fclose(pFilein);
	    fclose(pFileout);
	    free(imageData);

		while((strcmp(shareMemory, "done") != 0));
		memset(shareMemory, 0, 10);
		system("./mxc_vpu_test.out -E \"-i /work/_Image/vputest.yuv -w 960 -h 620 -o /var/www/_Image/vputest.jpg -f 7\"");
		gettimeofday(&t1, NULL);
        printf("%d\n",(int)t1.tv_usec % 1000);
	}
	if(strcmp(input, "7") == 0){
		memset(shareMemory, 0, 10);
		ptr = "Stop";
		strcpy(shareMemory, ptr);
		printf("set shareMemroy to Stop done\n");
	}
	
	
		 //  	if((pFileDisObj = fopen("_Image/objectDis.yuv","r")) == NULL){
	 //        printf("Cannot open objectDis.yuv!\n", i);
	 //        return 0;
		// }

		// fread(imageDistortion, 2, 450 * 500, pFileDisObj);

		// memset(imageDistortionToHTML, 0x2C, 450 * 500 * 2 + 1);

		// for(i = 0; i < 450 * 500; i++){
		// 	if(imageDistortion[i] <  5)
		// 		imageDistortionToHTML[i * 2 + 1] = (char)imageDistortion[i] + 0x30;
		// 	else
		// 		imageDistortionToHTML[i * 2 + 1] = 0x30;
		// }
		// imageDistortionToHTML[0] = '[';
		// imageDistortionToHTML[450 * 500 * 2] = ']';
	 //  	printf("%s", imageDistortionToHTML);
	
	// free(imageDistortion);
	// free(imageDistortionToHTML);
	return 0;
}
