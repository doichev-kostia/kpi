section .data
    number db -2

section .text
global _start

_start:
    ; if x is in boundary [-6, 127] then print x
    ; otherwise jump to invalid

    xor rax, rax
    ; if I use movzx it will be 254
    ; if I use movsx it will be -2
    movsx rax, byte [number]
    mov rdx, -6
    cmp rax, rdx
    jl invalid

    mov rbx, 127
    cmp rax, rbx
    jg invalid

    jmp exit

invalid:
    mov rax, 60
    mov rdi, 1
    syscall

exit:
    mov rax, 60
    mov rdi, 0
    syscall