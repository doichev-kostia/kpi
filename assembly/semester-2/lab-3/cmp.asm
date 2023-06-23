section .data
    number dq -2

section .text
global _start

_start:
    ; if x is in boundary [-6, 127] then print x
    ; otherwise jump to invalid

    ; mov rax, -2 ; works perfeclty
    xor rax, rax
    mov rax, qword [number]
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