section .data
codes:
    db '0123456789ABCDEF'
newline:
    db 10

section .text
global _start
_start:
    mov rax, 0x1122334455667788

    mov rdi, 1 ; stdout
    mov rdx, 1 ; 1 byte at a time.
    mov rcx, 64 ; num of iterations * 4.
.loop:
    push rax
    sub rcx, 4
    sar rax, cl ; shift by 60, then 56, etc.
    and rax, 0xf ; extract the current most sig 4 bits.

    lea rsi, [codes + rax] ; extract the address of corresponding hex symbol.
    mov rax, 1 ; write syscall.

    push rcx ; store rcx because it will be modified by syscall.
    syscall
    pop rcx

    pop rax
    test rcx, rcx ; loop exit condition (rcx == 0?)
    jnz .loop

    mov rax, 1
    mov rsi, newline
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall
