section .data
    x_msg db "Enter the value of x: ", 0
    result_msg db "Result: ", 0

section .bss
    x resb 8       ; 64-bit value for x
    result resb 16 ; Buffer for result string

section .text
global _start

_start:
    ; Prompt user to enter the value of x
    mov rax, 1
    mov rdi, 1
    mov rsi, x_msg
    mov rdx, 20
    syscall

    ; Read user input for x
    mov rax, 0
    mov rdi, 0
    mov rsi, x
    mov rdx, 8
    syscall

    ; Convert x from string to integer
    mov rax, x
    mov rdi, 0
    call atoi64

    ; Perform the desired calculations based on the value of x
    cmp rax, 0
    jg positive
    cmp rax, -5
    jl negative
    jmp zero_or_between

positive:
    ; Calculate 8x^2 + 36/x
    mov rdi, rax    ; Store x in rdi
    mul rax         ; rax = x^2
    mov rbx, 8
    imul rax, rbx   ; rax = 8x^2
    mov rbx, 36
    idiv rbx        ; rax = 8x^2 + 36/x
    ret

negative:
    ; Calculate (1+x) / (1-x)
    add rax, 1      ; rax = 1 + x
    mov rdi, rax    ; Store 1 + x in rdi
    sub rax, 1      ; rax = x
    mov rbx, 1
    sub rbx, rax    ; rbx = 1 - x
    idiv rbx        ; rax = (1+x) / (1-x)
    ret

zero_or_between:
    ; Calculate 10x^2
    mov rdi, rax    ; Store x in rdi
    mul rax         ; rax = x^2
    mov rbx, 10
    imul rax, rbx   ; rax = 10x^2

exit:
    ; Exit the program
    mov rax, 60
    xor rdi, rdi
    syscall

; Function to convert string to 64-bit signed integer (atoi64)
; Input: rdi - Pointer to the string
; Output: rax - Integer value
atoi64:
    xor rax, rax
    mov rcx, 10
atoi64_loop:
    movzx edx, byte [rdi]
    inc rdi
    cmp dl, 0x0A
    je
