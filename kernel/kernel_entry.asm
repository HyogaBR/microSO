; Entrada do kernel (chamado pelo stage2)
[BITS 32]
[extern kernel_main]    ; Função C
[global kernel_entry]

kernel_entry:
    mov esp, 0x9000      ; Stack pointer
    call kernel_main      ; Chama C!
    cli
    hlt
    jmp $                 ; Nunca retorna
