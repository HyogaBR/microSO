[BITS 16]

; =============================================
; print_string - imprime string terminada em zero
; Entrada: SI = ponteiro para a string
; =============================================
print_string:
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
; load_kernel - carrega kernel do disco
; Stage2 está em 0x7E00, Kernel vai para 0x10000
; =============================================
load_kernel:
    pusha
    mov si, trying_load_msg
    call print_string

    mov dl, 0x00        ; drive A:

    ; Lê 10 setores do kernel (aprox 5 KB)
    mov ah, 0x02        ; função INT13h
    mov al, 10          ; número de setores
    mov ch, 0           ; cilindro
    mov dh, 0           ; cabeça
    mov cl, 5           ; setor inicial = 5
    mov bx, 0           ; offset dentro do segmento ES
    mov ax, 0x1000
    mov es, ax          ; segmento destino = 0x1000
    int 0x13
    jc .error

    mov si, kernel_ok_msg
    call print_string
    popa
    ret

.error:
    mov si, disk_error_msg
    call print_string
    jmp $

; =============================================
; Mensagens
; =============================================
trying_load_msg: db "Loading kernel...", 0x0D, 0x0A, 0
kernel_ok_msg:   db "Kernel OK!", 0x0D, 0x0A, 0
disk_error_msg:  db "DISK ERROR!", 0x0D, 0x0A, 0
