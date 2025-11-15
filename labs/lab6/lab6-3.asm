%include 'in_out.asm'
SECTION .data
msg db "Result: ",0
SECTION .text
global _start
_start:
mov eax,4        
mov ebx,6
mul ebx          
add eax,2      
mov ebx,5       
div ebx            
mov edi,eax     
mov eax,msg
call sprint
mov eax,edi
call iprintLF
call quit
