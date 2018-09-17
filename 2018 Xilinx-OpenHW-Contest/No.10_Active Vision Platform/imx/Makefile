SYSROOTPATH ?=/home/jay/work/31452/rootfs
CFLAGS = -march=armv7-a -mfloat-abi=hard -mfpu=neon -mtune=cortex-a9 --sysroot=${SYSROOTPATH}
TARGET = hello
INCLUDE = ../../common


$(TARGET): %:%.c
	$(CROSS_COMPILE)gcc -o $(TARGET) $< $(CFLAGS) $(INCLUDE)/*.c  
clean:
	rm -f $(TARGET)