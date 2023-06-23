section .data
    x db 10  ; Example value of x

section .bss
    whole_number resb 8
    numerator resb 8
    denominator resb 8

section .text
    global _start

_start:
    xor rax, rax
    ; Clear the variables
    mov [whole_number], rax
    mov [numerator], rax
    mov [denominator], rax

    call execute


; if (x > 0) {
; 8x^2 + 36/x
; } else if (-5 <= x && x <= 0) {
; (1+x) / (1-x)
; } else {
; 10x^2
; }

execute:
    movsx rax, byte [x]   ; Load the value of x into AL

    ; Check if x > 0
    cmp rax, 0
    jg positive

    ; Check if x <= 20
    cmp rax, -5
    jl negative


    ; if (-5 <= x && x <= 0)
    ; (1 + x) / ( 1 - x )

    ; Compute (1 + x)
    movsx rax, al  ; Zero-extend AL to EAX
    ;persist x
    mov rdx, rax
    add rax, 1

    mov rbx, rax ; persist (1 + x)

    ; Compute (1 - x)
    mov rcx, 1
    sub rcx, rdx

    ; Compute (1 + x) / ( 1 - x )

    mov rax, rbx
    mov rbx, rcx
    xor rdx, rdx ; clear rdx
    div rbx

    mov [whole_number], rax
    call handle_decimal

    jmp exit

handle_decimal:
    cmp rdx, 0
    jne handle_fraction
    ret

handle_fraction:
    mov [numerator], rdx
    mov [denominator], rbx

    ret

positive:
    ; Code to execute if x > 0
    ; 8x^2 + 36/x
    ; Compute x^2
    movsx rax, al  ; Zero-extend AL to RAX
    mul rax ; Square the value of x

    ; Compute 8x^2
    mov rbx, 8
    mul rbx ; Multiply 8 by x^2

    movsx rbx, byte [x]

    ; persist 8x^2
    mov rcx, rax

    ; Compute 36/x
    mov rax, 36
    xor rdx, rdx ; clear rdx
    div rbx ; Divide 36 by x

    ; Compute 8x^2 + 36/x
    add rcx, rax

    mov [whole_number], rcx
    call handle_decimal

    ret

negative:
    ; Code to execute if x < -5
    ; 10x^2
    ; Compute x^2
    movsx rax, al  ; Zero-extend AL to EAX
    mul rax ; Square the value of x

    ; Compute 10x^2
    mov rbx, 10
    mul rbx ; Multiply 10 by x^2

    mov [whole_number], rax
    call handle_decimal

    ret

exit:
    mov rax, 60
    mov rdi, 0
    syscall

