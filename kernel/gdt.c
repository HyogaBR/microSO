#include "gdt.h"

struct gdt_entry gdt[3];
struct gdt_ptr gdtp;

void init_gdt(void) {
  // Null descriptor
  gdt[0].limit_low = 0;
  gdt[0].base_low = 0;
  gdt[0].base_middle = 0;
  gdt[0].access = 0;
  gdt[0].flags_limit_high = 0;
  gdt[0].base_high = 0;

  // Code segment (0x08)
  gdt[1].limit_low = 0xFFFF;
  gdt[1].base_low = 0;
  gdt[1].base_middle = 0;
  gdt[1].access = 0x9A;
  gdt[1].flags_limit_high = 0xCF;
  gdt[1].base_high = 0;

  // Data segment (0x10)
  gdt[2].limit_low = 0xFFFF;
  gdt[2].base_low = 0;
  gdt[2].base_middle = 0;
  gdt[2].access = 0x92;
  gdt[2].flags_limit_high = 0xCF;
  gdt[2].base_high = 0;

  // Configura GDTR
  gdtp.limit = sizeof(gdt) - 1;
  gdtp.base = (uint32_t)&gdt[0];

  // Carrega a GDT
  asm volatile("lgdt %0" : : "m"(gdtp) : "memory");

  // Far jump + recarga de segmentos (versão simplificada e segura)
  asm volatile("ljmp $0x08, $1f\n\t"
               "1:\n\t"
               "movw $0x10, %%ax\n\t"
               "movw %%ax, %%ds\n\t"
               "movw %%ax, %%es\n\t"
               "movw %%ax, %%fs\n\t"
               "movw %%ax, %%gs\n\t"
               "movw %%ax, %%ss\n\t"
               "movl $0x90000, %%esp" ::
                   : "eax", "memory");
}
