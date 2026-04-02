# =============================================
# SamuelOS - Kernel Makefile
# =============================================

CC = gcc
AS = nasm

CFLAGS = -m32 -ffreestanding -fno-pic -fno-stack-protector -nostdlib -Wall -Wextra -O2 -Iinclude
ASFLAGS = -f elf32

all: kernel.bin

kernel.bin: kernel_entry.o main.o gdt.o
	$(CC) -m32 -Ttext 0x10000 -nostdlib -Wl,--oformat=binary \
		-o ../build/kernel.bin kernel_entry.o main.o gdt.o

kernel_entry.o: kernel_entry.asm
	$(AS) $(ASFLAGS) kernel_entry.asm -o kernel_entry.o

main.o: main.c
	$(CC) $(CFLAGS) -c main.c -o main.o

gdt.o: gdt.c
	$(CC) $(CFLAGS) -c gdt.c -o gdt.o

clean:
	rm -f *.o ../build/kernel.bin

.PHONY: all clean
