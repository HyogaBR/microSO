[BITS 16]
[ORG 0x7C00]

start:
    cli
    cld
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    ; Limpa a tela
    mov ax, 0x0003
    int 0x10

    mov si, welcome_msg
    call print_msg

    mov si, loading_msg
    call print_msg

    call load_stage2   ; Carrega Stage 2

    jmp 0x7E00         ; Pula para Stage 2

; =============================================
print_msg:
    pusha
.loop:
    lodsb
    test al, al
    jz .done
    mov ah, 0x0E
    mov bh, 0
    int 0x10
    jmp .loop
.done:
    popa
    ret

; =============================================
load_stage2:
    pusha
    mov si, trying_load_msg
    call print_msg

    mov ah, 0x02        ; Função: ler setores
    mov al, 3           ; 3 setores do stage2
    mov ch, 0
    mov dh, 0
    mov cl, 2           ; Lê do setor 2 (setor 1 é boot)
    mov dl, 0x00        ; Floppy A
    mov bx, 0x7E00
    mov es, bx
    xor bx, bx
    int 0x13
    jc .disk_error

    mov si, stage2_ok_msg
    call print_msg
    popa
    ret

.disk_error:
    mov si, disk_error_msg
    call print_msg
    jmp $

; Mensagens
welcome_msg:      db "Welcome to SamuelOS!", 0x0D, 0x0A, 0
loading_msg:      db "Loading Stage 2...", 0x0D, 0x0A, 0
trying_load_msg:  db "Trying to load Stage 2...", 0x0D, 0x0A, 0
stage2_ok_msg:    db "Stage 2 loaded OK!", 0x0D, 0x0A, 0
disk_error_msg:   db "Disk error loading Stage 2!", 0x0D, 0x0A, 0

times 510 - ($ - $$) db 0
dw 0xAA55
