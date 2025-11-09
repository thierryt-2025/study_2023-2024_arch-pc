%include 'in_out.asm'
SECTION .data
    msg: DB 'Enter a string:',0

SECTION .bss
    buf1: RESB 80

SECTION .text
    GLOBAL _start
_start:
    mov eax, msg
    call sprint

    mov ecx, buf1
    mov edx, 80
    call sread

    call quit
