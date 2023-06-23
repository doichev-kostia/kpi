section .data
    text1 db "What is your name? "
    text1_len equ $ - text1
    text2 db "Hello, "
    text2_len equ $ - text2

section .bss
    name resb 16 ; reserve 16 bytes for name

global _start

section .text


_start:
    call _printText1
    call _getName
    call _printText2
    call _printName

    mov rax, 60
    mov rdi, 0
    syscall

_printText1:
    mov rax, 1
    mov rdi, 1
    mov rsi, text1
    mov rdx, text1_len
    syscall
    ret

_getName:
    mov rax, 0
    mov rdi, 0
    mov rsi, name
    mov rdx, 16
    syscall
    ret


_printText2:
    mov rax, 1
    mov rdi, 1
    mov rsi, text2
    mov rdx, text2_len
    syscall
    ret

_printName:
    mov rax, 1
    mov rdi, 1
    mov rsi, name
    mov rdx, 16
    syscall
    ret