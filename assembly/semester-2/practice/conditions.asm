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
    ret

elseif:
    cmp rax, rcx
    jne else
    mov rdx, rcx
    ret

else:
    mov rdx, 1
    ret

_start:
    mov rax, 3
    mov rbx, 4
    mov rcx, 5
    mov rdx, 0
    call if ; I have to use call here, otherwise, the program will come back to the beginning if the _start and will get stuck in an infinite loop
    jmp exit


exit:
    mov rax, 60
    mov rbx, 0
    syscall