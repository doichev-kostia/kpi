section .data
    input_message db "Enter a number in range [127, -128]: ", 0
    output_message db "The number is: ", 0
    invalid_input db "Invalid input!", 0
    is_positive db 1

section .bss
    number_ascii resb 4
    number resb 1
    input_length resb 1

section .text
global _start

; 1. ✅ Read a number from the console
; 2. ✅ Check whether it has an overflow, by checking the length of the string using '\n' as a delimiter
; 3. ✅ Check whether it's a positive or negative number
; 4. Check whether the input is actually a number, in case is_positive is 0, skip 1 char
; 5. Check whether it's in the range [127, -128]
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
    call _validateSign
    call _transformNumber
    call _applySign
    call _isInRange
    call _performSubtraction
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

 ; void
 _validateSign:
    mov rax, number_ascii
    mov cl, [rax]
    cmp cl, 0x2D ; -
    je _setNegative
    ret

; output: void
_setNegative:
    mov byte [is_positive], 0
    ret

_transformNumber:
    mov rdx, number_ascii ; pointer to the string
    mov rbx, 0 ; counter
    mov rcx, [input_length] ; number of ranks
    mov cl, [rdx] ; current char
    cmp byte [is_positive], 0
    call _handleNegative

_transformLoop:
    mov cl, [rdx + rbx] ; current char
    sub cl, 48 ; convert to number
    ; verify whether the cl is a number, cl >= 0 && cl <= 9
    cmp cl, 0
    jl _invalidInput
    cmp cl, 9
    jg _invalidInput

    ; shift rank
    mov rax, 10
    mul rcx ; rax = rax * rcx

    ; add the current rank
    mov rdx, rax ; transform the number to rdx:rax
    mov rax, cl ; move the number to rax
    mul rdx ; rax = rax * rdx
    add [number], rax ; add the current rank to the number

    inc rbx ; move to the next char
    dec rcx ; decrease the number of ranks
    cmp rcx, 0
    jne _transformLoop
    ret

; input: rdx - number_ascii, rbx - counter, rcx - number of ranks
_handleNegative:
    mov cl, [rdx + 1] ; skip the '-' char
    inc rbx ; move to the next char
    dec rcx ; decrease the number of ranks
    ret

_applySign:
    cmp byte [is_positive], 0
    je _applyNegative
    ret

_applyNegative:
    mov rax, [number]
    neg rax
    mov [number], rax
    ret

_isInRange:
    mov rax, [number]
    cmp rax, 127
    jg _invalidInput
    cmp rax, -128
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
    mov rax, number
    ; if the number is negative, add the '-' char
    cmp byte [is_positive], 0
    je _addNegativeChar

_addNegativeChar:
    mov rdx, number_ascii
    mov byte [rdx], 0x2D
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