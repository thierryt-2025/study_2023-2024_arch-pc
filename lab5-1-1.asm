SECTION .data
    msg: DB 'Enter a string:',10
    msgLen: EQU $-msg

SECTION .bss
    buf1: RESB 80

SECTION .text
    GLOBAL _start
_start:
    ; Print prompt
    mov eax,4
    mov ebx,1
    mov ecx,msg
    mov edx,msgLen
    int 80h

    ; Read string
    mov eax, 3
    mov ebx, 0
    mov ecx, buf1
    mov edx, 80
    int 80h

    ; Print entered string
    mov eax,4
    mov ebx,1
    mov ecx,buf1
    mov edx,80
    int 80h

    ; Exit program
    mov eax,1
    mov ebx,0
    int 80h
