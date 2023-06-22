; int x = 3, a = 4, b = 5, c = 0;
; if (x == a) {
;   c = c + a;
; } else if (x == b) {
;   c = b;
; } else {
;   c = 1
; }

; rax x
; rbx a
; rcx b
; rdx c

global _start

section .data

section .bss

section .text
if:
    cmp rax, rbx
    jne elseif
    add rdx, rbx
    jmp exit

elseif:
    cmp rax, rcx
    jne else
    mov rdx, rcx
    jmp exit

else:
    mov rdx, 1
    jmp exit

_start:
    mov rax, 3
    mov rbx, 4
    mov rcx, 5
    mov rdx, 0
    jmp if


exit:
    mov rax, 60
    mov rbx, 0
    syscall