global _start

section .data
message db "Hello, world", 10 ; 10 - \n
message_len equ $ - message ; $ - current address, message - start address of message (letter 'H')

section .bss

section .text

_start:
    mov rax, 1 ; sys_write
    mov rdi, 1 ; stdout
    mov rsi, message ; output char buffer
    mov rdx, message_len ; output char buffer length
    syscall

    jmp exit

exit:
    mov rax, 60
    mov rdi, 0
    syscall

