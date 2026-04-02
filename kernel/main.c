#include "gdt.h"
#include "include/gdt.h"

// kernel.c - Kernel em Modo Protegido 32-bit
void print_string(const char *str) {
  char *video = (char *)0xB8000;
  while (*str) {
    *video++ = *str++;
    *video++ = 0x07; // Cor cinza
  }
}

void kernel_main() {
  init_gdt();
  print_string("SamuelOS Kernel v1.0 - Modo Protegido!");
  print_string("C + Assembly = ❤️");

  // Loop infinito
  while (1) {
    asm("hlt");
  }
}
