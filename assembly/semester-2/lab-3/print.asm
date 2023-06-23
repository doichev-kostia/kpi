section .bss
    whole_number resb 8
    numerator resb 8
    denominator resb 8
    digitSpace resb 100
    digitSpacePos resb 8

section .text
    global _start

_start:
    xor rax, rax
    ; Clear the variables
    mov [whole_number], rax
    mov [numerator], rax
    mov [denominator], rax

    mov rax, 63
    mov [whole_number], rax

    mov rax, 2
    mov [numerator], rax

    mov rax, 3
    mov [denominator], rax

    mov rax, [whole_number]
    call _printRAX

    mov rax, [numerator]
    call _printRAX

    mov rax, [denominator]
    call _printRAX

_printRAX:
    mov rcx, digitSpace
    mov rbx, 10
    mov [rcx], rbx
    inc rcx
    mov [digitSpacePos], rcx

; 123 / 10 = 12 remainder 3, store 3
; 12 / 10 = 1 remainder 2, store 2
; 1 / 10 = 0 remainder 1, store 1
_printRAXLoop:
    mov rdx, 0
    mov rbx, 10
    div rbx
    push rax
    add rdx, 48 ; convert the remainder to ASCII

    mov rcx, [digitSpacePos]
    mov [rcx], dl
    inc rcx
    mov [digitSpacePos], rcx

    pop rax
    cmp rax, 0
    jne _printRAXLoop

_reverse:
    mov rcx, [digitSpacePos]

    mov rax, 1
    mov rdi, 1
    mov rsi, rcx
    mov rdx, 1
    syscall

    mov rcx, [digitSpacePos]
    dec rcx
    mov [digitSpacePos], rcx

    cmp rcx, digitSpace
    jge _reverse

    ret