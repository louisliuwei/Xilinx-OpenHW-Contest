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

void CreatShareMemory();

int main(int argc, char **argv)
{	
	if(argc > 1){
		printf("argv[1] = %d\n",atoi(argv[1]));
		CreatShareMemory();
		return 0;
	}

	int shmid;
	char* shareMemory;

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

	while(1){
		// if(strcmp(shareMemory, "hello") == 0){
		// 	printf("shareMemory is hello\n");
		// 	memset(shareMemory, 0, 10);
		// }
		printf("%s", shareMemory);
	}

	return 0;
}

void CreatShareMemory()
{
	int shmid;
	char* shareMemory;

	shmid = shmget(0x90, 10, SHM_W | SHM_R | IPC_CREAT | IPC_EXCL);

	if(shmid == -1){
		printf("cannot create share memory\n");
		return ;
	}

	shareMemory = shmat(shmid, 0, 0);
	memset(shareMemory, 0, 10);
	shmdt(shareMemory);
}