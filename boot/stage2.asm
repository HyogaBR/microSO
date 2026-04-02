; =============================================
; stage2.asm - Stage 2
; =============================================
[BITS 16]
[ORG 0x7E00]

stage2_start:
    cli
    cld

    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x9000

    mov si, entering_pm_msg
    call print_string

    call load_kernel      ; 16-bit carrega kernel em 0x10000

    ; === Setup GDT e entra em Protected Mode ===
    lgdt [gdtr]           ; GDT deve estar em 16-bit mode
    mov eax, cr0
    or al, 1              ; Habilita PE
    mov cr0, eax

    ; Far jump para 32-bit code segment
    jmp 0x08:protected_mode_32

; ================================
; Includes / utilidades
; ================================
%include "gdt.S"
%include "stage2_utils.S"

; ================================
[BITS 32]
protected_mode_32:
    mov ax, 0x10          ; Data segment
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    mov esp, 0x90000      ; Stack 32-bit

    call 0x10000          ; Kernel entry (kernel_entry.asm)

    cli
    hlt
    jmp $

; ================================
; Dados
; ================================
entering_pm_msg: db "Entering Protected Mode and loading kernel...", 0x0D, 0x0A, 0

times (512*3) - ($ - $$) db 0
