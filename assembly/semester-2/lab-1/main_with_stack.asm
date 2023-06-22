section .bss
    stack resb 64

section .data
    SOURCE   db 10, 20, 30, 40
    DEST     db 4 dup('?')

section .text
global _start

_start:
    ; Save the DS register on the stack
    push rdx

    ; Initialize AX to 0
    xor ax, ax
    push ax

    ; Zero out the DEST array
    mov byte [DEST], 0
    mov byte [DEST+1], 0
    mov byte [DEST+2], 0
    mov byte [DEST+3], 0

    ; Copy the SOURCE array to DEST
    mov al, byte [SOURCE]
    mov byte [DEST+3], al
    mov al, byte [SOURCE+1]
    mov byte [DEST+2], al
    mov al, byte [SOURCE+2]
    mov byte [DEST+1], al
    mov al, byte [SOURCE+3]
    mov byte [DEST], al

    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80
