section .data
    input_message db "Enter a number in range [127, -6]: ", 0
    output_message db "The number is: ", 0
    whole_str db "Whole number: ", 0
    numerator_str db "Numerator: ", 0
    denominator_str db "Denominator: ", 0
    invalid_input db "Invalid input!", 0
    is_positive db 1

section .bss
    number_ascii resb 4
    number resb 1
    input_length resb 1
    whole_number resb 8
    numerator resb 8
    denominator resb 8
    digitSpace resb 100
    digitSpacePos resb 8

section .text

global _start

_start:
    mov rax, input_message
    call _print

    call _getNumber

    call _exit

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
    call _execFunction

    mov rax, output_message
    call _print

    mov rax, whole_str
    call _print

    mov rax, [whole_number]
    call _printRAX

    mov rax, numerator_str
    call _print

    mov rax, [numerator]
    call _printRAX

    mov rax, denominator_str
    call _print

    mov rax, [denominator]
    call _printRAX

    ret

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
    mov rdi, [input_length] ; number of ranks
    call _handleNegative
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
    movsx rax, cl ; rax = cl
    mul rdx ; rax = rax * rdx
    add [number], rax ; add the current rank to the number

    inc rbx ; move to the next char
    dec rdi ; decrease the number of ranks
    mov rdx, number_ascii ; reset the pointer to the string
    cmp rdi, 0
    jge _transformLoop
    ret

_handleNegative:
    cmp byte [is_positive], 0
    je _handleNegativeEnd
    ret

_handleNegativeEnd:
    sub rdi, 1 ; decrease the number of ranks by 1, because the first char is '-'
    inc rbx ; skip '-'
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
    ; [-6, 127]
    movsx rax, byte [number]
    cmp rax, 127
    jg _invalidInput
    cmp rax, -6
    jl _invalidInput
    ret

_applySign:
    cmp byte [is_positive], 0
    je _applyNegative
    ret

_applyNegative:
    mov al, byte [number]
    neg al
    mov [number], al
    ret
; VALIDATION END

; OPERATIONS

; if (x > 0) {
; 8x^2 + 36/x
; } else if (-5 <= x && x <= 0) {
; (1+x) / (1-x)
; } else {
; 10x^2
; }

_handleDecimal:
    cmp rdx, 0
    jne _handleFraction
    ret

_handleFraction:
    mov [numerator], rdx
    mov [denominator], rbx
    ret

_execFunction:
    mov al, [number]   ; Load the value of x into AL
    movsx rax, al   ; Load the value of x into AL

    ; Check if x > 0
    cmp rax, 0
    jg _positive

    ; Check if -5 < x
    cmp rax, -5
    jl _negative

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
    call _handleDecimal

    ret

_positive:
    ; Code to execute if x > 0
    ; 8x^2 + 36/x
    ; Compute x^2
    movsx rax, al  ; Zero-extend AL to RAX
    mul rax ; Square the value of x

    ; Compute 8x^2
    mov rbx, 8
    mul rbx ; Multiply 8 by x^2

    movsx rbx, byte [number]

    ; persist 8x^2
    mov rcx, rax

    ; Compute 36/x
    mov rax, 36
    xor rdx, rdx ; clear rdx
    div rbx ; Divide 36 by x

    ; Compute 8x^2 + 36/x
    add rcx, rax

    mov [whole_number], rcx
    call _handleDecimal

    ret


_negative:
    ; Code to execute if x < -5
    ; 10x^2
    ; Compute x^2
    movsx rax, al  ; Zero-extend AL to EAX
    mul rax ; Square the value of x

    ; Compute 10x^2
    mov rbx, 10
    mul rbx ; Multiply 10 by x^2

    mov [whole_number], rax
    call _handleDecimal

    ret
; OPERATIONS END


; TRANSFORMATION

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