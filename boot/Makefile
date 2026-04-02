# =============================================
# SamuelOS - Boot Makefile
# =============================================

ASM = nasm
BUILD_DIR = $(shell pwd)/../build

all: boot.bin stage2.bin

boot.bin: boot.asm
	@mkdir -p $(BUILD_DIR)
	$(ASM) -f bin boot.asm -o $(BUILD_DIR)/boot.bin

stage2.bin: stage2.asm
	@mkdir -p $(BUILD_DIR)
	$(ASM) -f bin stage2.asm -o $(BUILD_DIR)/stage2.bin

clean:
	rm -f $(BUILD_DIR)/boot.bin $(BUILD_DIR)/stage2.bin

.PHONY: all clean
