ENTRY(kernel_entry)

SECTIONS {
    . = 0x10000;         ; Kernel em 0x9000

    .text : {
        *(.text)
    }

    .data : {
        *(.data)
    }

    .bss : {
        *(.bss)
    }
}
