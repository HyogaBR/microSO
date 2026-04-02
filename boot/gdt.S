; =============================================
; Global Descriptor Table (GDT) - Flat 32-bit
; =============================================

[BITS 16]   ; Mantemos em 16-bit porque este arquivo é incluído no stage2 (ainda 16-bit)

gdt_start:

; Entry 0: Null Descriptor (obrigatório)
gdt_null:
    dd 0x00000000
    dd 0x00000000

; Entry 1: Code Segment (Kernel - Ring 0)
gdt_code:
    dw 0xFFFF           ; Limit low
    dw 0x0000           ; Base low
    db 0x00             ; Base middle
    db 0b10011010       ; Access: P=1, DPL=0, Code, Non-conforming, Readable
    db 0b11001111       ; Flags: G=1 (4KiB), D=1 (32-bit)
    db 0x00             ; Base high

; Entry 2: Data Segment (Kernel - Ring 0)
gdt_data:
    dw 0xFFFF           ; Limit low
    dw 0x0000           ; Base low
    db 0x00             ; Base middle
    db 0b10010010       ; Access: P=1, DPL=0, Data, Writable
    db 0b11001111       ; Flags: G=1, D=1
    db 0x00             ; Base high

gdt_end:

; =============================================
; GDTR - GDT Pointer
; =============================================
gdtr:
    dw gdt_end - gdt_start - 1    ; Limit (tamanho - 1)
    dd gdt_start                  ; Endereço linear da GDT
