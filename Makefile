# =============================================
# SamuelOS - Makefile Raiz
# =============================================

.PHONY: all boot kernel run clean

all: samuelos.img

boot:
	@mkdir -p build
	$(MAKE) -C boot

kernel:
	@mkdir -p build
	$(MAKE) -C kernel

samuelos.img: boot kernel
	@mkdir -p build
	# Concatena corretamente: boot + stage2 + kernel
	cat build/boot.bin build/stage2.bin build/kernel.bin > build/samuelos.img
	@echo "✓ SamuelOS imagem gerada com sucesso: build/samuelos.img (boot + stage2 + kernel)"

run: samuelos.img
	qemu-system-i386 -fda build/samuelos.img \
		-m 128M -no-reboot -no-shutdown

clean:
	$(MAKE) -C boot clean
	$(MAKE) -C kernel clean
	rm -rf build/*

boot-only:
	@mkdir -p build
	$(MAKE) -C boot

kernel-only:
	@mkdir -p build
	$(MAKE) -C kernel

.PHONY: all run clean boot-only kernel-only
