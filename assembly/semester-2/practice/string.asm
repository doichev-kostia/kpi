section .data
    text db "Hello, world!", 10, 0 ; 10 - \n, 0 - end of string
    text2 db "World!", 10, 0

section .text
global _start

_start:
    mov rax, text
    call _print

    mov rax, text2
    call _print

    mov rax, 60
    mov rdi, 0
    syscall


;input: rax as pointer to string
; output: print string at rax

_print:
    push rax
    mov rbx, 0 ; counter of the length

_printLoop:
    inc rax
    inc rbx
    mov cl, [rax] ; kind of a cursor that points to the current character of a string
    cmp cl, 0 ; we will continue looping until the terminating character with ascii code of 0
    jne _printLoop

    mov rax, 1
    mov rdi, 1
    pop rsi ; get the pointer of rax from the stack
    mov rdx, rbx
    syscall

    ret