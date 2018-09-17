#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <errno.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <termios.h>
#include <stdlib.h>

#define SYSFS_GPIO_EXPORT           "/sys/class/gpio/export"  

#define SYSFS_GPIO_RST_PIN_VAL      "1"   

#define SYSFS_GPIO_RST_DIR          "/sys/class/gpio/gpio1/direction"

#define SYSFS_GPIO_RST_DIR_VAL      "out" //LOWERCASE

#define SYSFS_GPIO_RST_VAL          "/sys/class/gpio/gpio1/value"

#define SYSFS_GPIO_RST_VAL_H        "1"

#define SYSFS_GPIO_RST_VAL_L        "0"

 

int main()
{
  int fd_GPIO;

  fd_GPIO = open(SYSFS_GPIO_EXPORT, O_WRONLY);

  if(fd_GPIO == -1){
    printf("ERR: export open error.\n");
    return (-1);
  }      

  write(fd_GPIO, SYSFS_GPIO_RST_PIN_VAL, sizeof(SYSFS_GPIO_RST_PIN_VAL));
  close(fd_GPIO);

  fd_GPIO = open(SYSFS_GPIO_RST_DIR, O_WRONLY);

  if(fd_GPIO == -1){
    printf("ERR: dir open error.\n");
    return (-1);
  }      

  write(fd_GPIO, SYSFS_GPIO_RST_DIR_VAL, sizeof(SYSFS_GPIO_RST_DIR_VAL));
  close(fd_GPIO);


  fd_GPIO = open(SYSFS_GPIO_RST_VAL, O_RDWR);

  if(fd_GPIO == -1){
    printf("ERR: value open error.\n");
    return (-1);
  }      

  while(1){
    write(fd_GPIO, SYSFS_GPIO_RST_VAL_L, sizeof(SYSFS_GPIO_RST_VAL_L));
    write(fd_GPIO, SYSFS_GPIO_RST_VAL_H, sizeof(SYSFS_GPIO_RST_VAL_H));
  }

  close(fd_GPIO);

  return 0;
}





