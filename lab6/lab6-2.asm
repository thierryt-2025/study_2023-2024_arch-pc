%include 'in_out.asm'
SECTION .data
msg db "Result: ",0
SECTION .text
global _start
_start:
mov eax,6        
mov ebx,4        
add eax,ebx      
mov edi,eax
mov eax,msg
call sprint
mov eax,edi
call call iprint  
call quit
