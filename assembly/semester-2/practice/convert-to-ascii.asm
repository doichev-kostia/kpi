section .data
    number db 0            ; Buffer to store the string
    digits db '00000000'   ; Buffer for temporary storage of digits

section .text
global _start

_start:
    mov eax, 34              ; Number to convert
    mov ecx, 10              ; Base 10

    xor ebx, ebx             ; Initialize ebx to 0 (index for digits buffer)

convert_loop:
    xor edx, edx             ; Clear edx for division
    div ecx                  ; Divide eax by ecx (10)

    add dl, '0'              ; Convert remainder to ASCII character
    mov [digits + ebx], dl   ; Store digit in the digits buffer

    inc ebx                  ; Increment the index

    test eax, eax            ; Check if eax is zero
    jnz convert_loop         ; If not zero, continue the loop

    ; Reverse the order of digits in the digits buffer
    mov esi, ebx             ; esi = number of digits
    mov edi, 0               ; edi = index for number buffer

reverse_loop:
    dec ebx                  ; Decrement the index
    mov dl, [digits + ebx]   ; Get a digit from the digits buffer
    mov [number + edi], dl   ; Store digit in the number buffer
    inc edi                  ; Increment the index for number buffer

    test ebx, ebx            ; Check if ebx is zero
    jnz reverse_loop         ; If not zero, continue the loop

    mov byte [number + edi], 0  ; Null-terminate the string

    mov ebx, edi

    ; Write the string to stdout
    mov eax, 1               ; System call number for write
    mov edi, 1               ; File descriptor (stdout)
    mov esi, number          ; Pointer to string
    mov edx, ebx             ; String length
    syscall                  ; Invoke operating system to perform operation

    ; Exit the program
    mov eax, 60              ; System call number for exit
    xor edi, edi             ; Exit status (0)
    syscall                  ; Invoke operating system to exit
