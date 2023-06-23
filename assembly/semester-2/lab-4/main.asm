section .data
    array_size_msg db "Choose an array size [2, 3]: ", 0
    invalid_input db "Invalid input!", 0
    array_el_msg db "Enter array element [0, 5]: ", 0
    array db 3 dup(0)
    sum_msg db "Sum: ", 0
    sum db 0

section .bss
    array_size resb 0
    number_ascii resb 2
    number resb 1
    input_length resb 1
    digitSpace resb 100
    digitSpacePos resb 8

section .text
global _start

_start:
    call _getArraySize
    call _getArrayElements

    lea rax, [_sum]
    call _forEach

    mov rax, sum_msg
    call _print

    mov rax, [sum]
    call _printRAX

    jmp _exit

_getArraySize:
   mov rax, array_size_msg
   call _print

   mov rax, 0
   mov rdi, 0
   mov rsi, array_size
   mov rdx, 2 ; number + '\n'
   syscall

   call _validateOverflow
   call _transformNumber
   ; assign number value to rax
   movzx rax, byte [number]
   mov rbx, 3 ; max value
   mov rcx, 2 ; min value
   call _isInRange
   mov [array_size], [number]


   ret

_getArrayElements:
    mov rbx, 0 ; counter


_getArrayElementsLoop:
    cmp r8, 0

    ; ask for array element
    mov rax, array_el_msg
    call _print

    ; read array element
    mov rax, 0
    mov rdi, 0
    mov rsi, number_ascii
    mov rdx, 2 ; number + '\n'
    syscall

    ; validate the input
    call _validateOverflow
    call _transformNumber

    ; assign number value to rax
    movzx rax, byte [number]
    mov rbx, 5 ; max value
    mov rcx, 0 ; min value
    call _isInRange
    mov [array + r8b], [number]

    inc r8
    cmp r8, array_size
    jl _getArrayElementsLoop
    ret


_forEach:
    mov r8, 0 ; counter
    mov r9, [array_size] ; array size

; rax - pointer to the subroutine
_forEachLoop:
    mov rdi, [array + r8]
    call rax

    inc r8
    cmp r8, r9
    jl _forEachLoop
    ret

; input: rdi - array element
_sum:
    add [sum], rdi
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
    cmp rbx, 2 ; max length of the string
    jge _invalidInput ; in case the string is too long (overflow)
    mov [input_length], rbx ; persist the length of the string
    mov cl, [rax] ; current char
    cmp cl, 0x0A ; in case it is the end of the string
    jne _validateLoop
    ret

; will save the actual number in [number] variable
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

;rax - current value,  rbx - max value, rcx - min value
_isInRange:
    cmp rax, rbx
    jg _invalidInput
    cmp rax, rcx
    jl _invalidInput
    ret

; VALIDATION END
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