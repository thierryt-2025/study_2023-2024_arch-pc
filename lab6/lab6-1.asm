%include 'in_out.asm'

SECTION .data
msg db "Result: ",0

SECTION .text
global _start

_start:
    ; Calculate 6 + 4 (as characters)
    mov eax, '6'
    mov ebx, '4'
    add eax, ebx
    
    ; Save result
    mov edi, eax
    
    ; Print "Result: "
    mov eax, msg
    call sprint
    
    ; Print the result character
    mov eax, edi
    call sprintLF
    
    ; Exit properly
    mov eax,6     
    mov ebx,4       
    add eax,ebx     
