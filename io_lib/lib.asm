global _start

section .data

test_string: db "abcdef", 0
newline_char: db 10
char_buf: dq 0

section .text

; ==== PROC START ====
exit:
    mov rax, 60
    syscall
; ===== PROC END =====

; ==== PROC START ====
string_length:
    xor rax, rax

.loop:
    cmp byte[rdi + rax], 0
    je .end
    inc rax
    jmp .loop

.end:
    ret
; ===== PROC END =====

; ==== PROC START ====
print_string:
    call string_length
    mov rdx, rax

    mov rax, 1
    mov rsi, rdi
    mov rdi, 1
    syscall
    ret
; ===== PROC END =====

; ==== PROC START ====
print_char:
    mov [char_buf], rdi
    mov rax, 1
    mov rdi, 1
    mov rsi, char_buf
    mov rdx, 1
    syscall
    ret
; ===== PROC END =====

; ==== PROC START ====
print_newline:
    mov rdi, 10
    call print_char
    ret
; ===== PROC END =====

_start:
    mov rdi, test_string
    call print_string 
    call print_newline

    mov rdi, 's'
    call print_char
    call print_newline

    mov rdi, rax
    call exit
