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


execute:
    mov al, [x]   ; Load the value of x into AL

    ; Check if x > 1
    cmp al, 1
    jle less_than_or_equal_1

    ; Check if x <= 20
    cmp al, 20
    jg greater_than_20

    ; Code to execute if x > 1 && x <= 20
    ; 54 + x^2  / ( 1 + x )

    ; Compute x^2
    movzx rax, al  ; Zero-extend AL to EAX
    mul rax ; Square the value of x

    mov rbx, rax

    movzx rdx, byte [x]

    ; Compute (1 + x)
    add rdx, 1

    ; Divide x^2 by (1 + x)
    mov rax, rbx
    mov rbx, rdx
    xor rdx, rdx
    div rbx

    ; Add 54 to the result
    add rax, 54

    mov [whole_number], rax
    call handle_decimal

    jmp end

handle_decimal:
    cmp rdx, 0
    jne handle_fraction
    ret

handle_fraction:
    mov [numerator], rdx
    mov [denominator], rbx

    ret

less_than_or_equal_1:
    ; Code to execute if x <= 1
    ; 75x^2 - 17x

    ; Compute x^2
    movzx rax, al  ; Zero-extend AL to EAX
    mul rax ; Square the value of x

    ; Compute 75x^2
    mov rbx, 75
    mul rbx ; Multiply 75 by x^2

    movzx rdx, byte [x]

    ; persist 75x^2
    mov rbx, rax

    ; Compute 17x
    mov rax, 17
    ; imul ebx, al TODO
    mul rdx  ; Multiply 17 by x

    ; Compute 75x^2 - 17x
    sub rbx, rax

    ; Handle the result (in EAX) as need
    jmp end

greater_than_20:
    ; Code to execute if x > 20
    ; 85x / ( 1 + x )
    ; Load the value of x into AL
    mov al, [x]
    movzx rax, al  ; Zero-extend AL to EAX

    ; Compute (1 + x)
    mov rcx, rax
    add rcx, 1

    ; Compute 85x
    mov rbx, 85
    mul rbx ; Multiply 85 by x

    mov rbx, rcx
    xor rdx, rdx ; clear rdx

    ; Compute 85x / ( 1 + x )
    div rbx ; Divide 85x by (1 + x)

    ; Handle the result (in EAX) as needed

end:
    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80
