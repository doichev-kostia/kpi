section .data
    input_message db "Enter a number in range [127, 88]: ", 0
    output_message db "The number is: ", 0
    invalid_input db "Invalid input!", 0

section .bss
    number_ascii resb 4
    number resb 1
    input_length resb 1

section .text
global _start

; 1. ✅ Read a number from the console
; 2. ✅ Check whether it has an overflow, by checking the length of the string using '\n' as a delimiter
; 3. ✅ Check whether it's a positive or negative number
; 4. Check whether the input is actually a number
; 5. Check whether it's in the range [127, 88]
; 6. Convert the ascii code to a number by looping through the string and subtracting 48 (ascii code of '0') from each char
; 7. Subtract 88 from the number (required by the task)
; 8. Print the result

_start:
    mov rax, input_message
    call _print

    call _getNumber
    mov rax, output_message
    call _print

    mov rax, 1
    mov rdi, 1
    mov rsi, number_ascii
    mov rdx, 4
    syscall

    call _exit
; UTILS

_print:
    push rax
    mov rbx, 0; length counter

_printLoop:
    inc rax
    inc rbx
    mov cl, [rax] ; current char
    cmp cl, 0 ; in case it is the end of the string
    jne _printLoop

    mov rax, 1
    mov rdi, 1
    pop rsi
    mov rdx, rbx
    syscall

    ret
; UTILS END

_getNumber:
    mov rax, 0
    mov rdi, 0
    mov rsi, number_ascii
    mov rdx, 4
    syscall

    call _validateOverflow
    call _transformNumber
    call _isInRange
    call _performSubtraction
    call _convertToASCII
    ret
; VALIDATION

_validateOverflow:
    mov rax, number_ascii
    mov rbx, 0
    ; check whether the initial string is empty (entered only '\n')
    cmp byte [rax], 0x0A
    je _invalidInput

_validateLoop:
    inc rax ; next char
    inc rbx ; length counter
    cmp rbx, 4 ; max length of the string
    jge _invalidInput ; in case the string is too long (overflow)
    mov [input_length], rbx ; persist the length of the string
    mov cl, [rax] ; current char
    cmp cl, 0x0A ; in case it is the end of the string
    jne _validateLoop
    ret

_transformNumber:
    mov rdx, number_ascii ; pointer to the string
    mov rbx, 0 ; counter
    mov rdi, [input_length] ; number of ranks
    sub rdi, 1 ; decrease the number of ranks by 1, because the first rank is 10^0

_transformLoop:
    mov cl, [rdx + rbx] ; current char
    sub cl, 48 ; convert to number
    ; verify whether the cl is a number, cl >= 0 && cl <= 9
    cmp cl, 0
    jl _invalidInput
    cmp cl, 9
    jg _invalidInput

    ; shift rank
    call _ifPowerZero


    ; add the current rank
    mov rdx, rax ; transform the number to rdx:rax
    ; move the number to rax
    movzx rax, cl ; rax = cl
    mul rdx ; rax = rax * rdx
    add [number], rax ; add the current rank to the number

    inc rbx ; move to the next char
    dec rdi ; decrease the number of ranks
    mov rdx, number_ascii ; reset the pointer to the string
    cmp rdi, 0
    jge _transformLoop
    ret

; if (exp == 0) {
; rax = 1
; } else if (exp == 1) {
; rax = 10
; } else {
; calculate the power
; }

_ifPowerZero:
    mov rax, 1
    cmp rdi, 0
    jne _ifPowerOne
    ret

_ifPowerOne:
    mov rax, 10
    cmp rdi, 1
    jne _ifPowerLoop
    ret
_ifPowerLoop:
    mov rax, 10
    call _toPower
    ret

; input: mov rax, 10, rdi = exponent,
_toPower:
    ; copy rdi
    mov rsi, rdi
    cmp rsi, 1; check whether the exponent is 1
    je _toPowerEnd

_toPowerLoop:
    mov rdx, 10; base
    mul rdx
    dec rsi
    cmp rsi, 1
    jne _toPowerLoop
    ret

_toPowerEnd:
    ret

_isInRange:
    movzx rax, byte [number]
    cmp rax, 127
    jg _invalidInput
    cmp rax, 88
    jl _invalidInput
    ret


; VALIDATION END

; OPERATIONS
_performSubtraction:
    mov rax, [number]
    sub rax, 88
    mov [number], rax
    ret
; OPERATIONS END

; TRANSFORMATION
_convertToASCII:
    mov rax, [number]
    mov rbx, 0

_convertLoop:
    mov rdx, 10
    div rdx
    add rax, 48
    mov [number_ascii + rbx], al
    inc rbx
    cmp rax, 0
    jne _convertLoop
    ret

; TRANSFORMATION END

; TERMINATION

_invalidInput:
    mov rax, invalid_input
    call _print

    mov rax, 60
    mov rdi, 1
    syscall

_exit:
    mov rax, 60
    mov rdi, 0
    syscall

; TERMINATION END