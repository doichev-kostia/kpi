; TODO: fix instructions, because the rbx is not printed
global _start

section .data

section .bss

section .text

_start:
; rax, rdi, rsi, rdx - sys_write
; rbx - counter

    xor rbx, rbx
    jmp loop1

loop1:
    add rbx, '0' ; convert to an ascii character

    mov rax, 1 ; sys_write
    mov rdi, 1 ; stdout
    mov rsi, rbx ; character
    mov rdx, 1 ; length
    syscall

    sub rbx, '0' ; convert back to a number

    inc rbx

    cmp rbx, 5
    jl loop1

    jmp exit

exit:
    mov rax, 60
    mov rdi, 0
    syscall