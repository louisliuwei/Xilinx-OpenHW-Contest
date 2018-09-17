#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <errno.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <termios.h>
#include <stdlib.h>

char testChar[1] = {0x55};
char binaryFlag[1] = {0xff};
char grayFlag[1] = {0xfe};  
char pattern[22] = {0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x61, 
                    0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6a, 0x6b, 0x6c};



#define SYSFS_GPIO_EXPORT           "/sys/class/gpio/export"  

#define SYSFS_GPIO_RST_PIN_VAL      "9"   

#define SYSFS_GPIO_RST_DIR          "/sys/class/gpio/gpio9/direction"

#define SYSFS_GPIO_RST_DIR_VAL      "out" //LOWERCASE

#define SYSFS_GPIO_RST_VAL          "/sys/class/gpio/gpio9/value"

#define SYSFS_GPIO_RST_VAL_H        "1"

#define SYSFS_GPIO_RST_VAL_L        "0"

 

int main()
{
  int fd_I2C;
  int fd_GPIO;
  int temp;
  char buff[10];
  memset(buff,0,10);

  fd_I2C = open("/dev/i2c-2", O_RDWR);
  if (-1 == fd_I2C){
    perror("Can't i2c-2 Port");
    return(-1);
  }
  else 
    printf("open i2c-2 .....\n");

//0x0703 = I2C_SLAVE IT'S BEEN FOUND IN /home/jay/my-imx-3.14/02_source/linux-3.14.52/include/uapi/linux
  if(ioctl(fd_I2C, 0x0703, 0X34) < 0){
    perror("Can't set i2c-2 slave addr");
    return(-1);
  }

  fd_GPIO = open(SYSFS_GPIO_RST_VAL, O_RDWR);

  if(fd_GPIO == -1){
    printf("ERR: Radio hard reset pin open error.\n");
    return (-1);
  }      

  write(fd_GPIO, SYSFS_GPIO_RST_VAL_H, sizeof(SYSFS_GPIO_RST_VAL_H));

  while(1){
    printf("<< ");
    scanf("%d",buff);

    if(buff[0] == 0){
      write(fd_GPIO, SYSFS_GPIO_RST_VAL_L, sizeof(SYSFS_GPIO_RST_VAL_L));
      usleep(100000);
      write(fd_GPIO, SYSFS_GPIO_RST_VAL_H, sizeof(SYSFS_GPIO_RST_VAL_H));
      usleep(100000);
      write(fd_I2C, buff, 1);
      continue;
    }

    close(fd_GPIO);
    break;
  }

  // buff[0] = 0xFF;
  // write(fd_I2C, buff, 1);


  printf("Please input I2C send content\n");

  while(1){
    printf("<< ");
    scanf("%d",buff);
    
    
    if(buff[0] == 100){
      buff[0] = temp;
      while(1){
        write(fd_I2C, buff, 1);
        printf("buff[0] = %d\n", buff[0]);
        usleep(2000);
      }
    }

    if(buff[0] == 0xFF || buff[0] == 0xFE || buff[0] == 0xFD){
      write(fd_I2C, buff, 1);
      printf("buff[0] = %d\n", buff[0]);
      continue;
    }

    if(buff[0] > 21){
      printf("input number larger than 21\n");
      continue;
    }
    temp = buff[0];
    printf("buff[0] = %d\n", buff[0]);
    write(fd_I2C, buff, 1);
  }

  return 0;
}





