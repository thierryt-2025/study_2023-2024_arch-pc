%include 'in_out.asm'
SECTION .data
msg db "Enter your student ID number:",0
rem db "Your variant: ",0
SECTION .bss
x resb 10
SECTION .text
global _start
_start:
mov eax,msg     
call sprint
mov ecx,x       
mov edx,10     
call sread     
mov eax,x      
call atoi
xor edx,edx    
mov ebx,20      
div ebx          
inc edx         
mov eax,rem     
call sprint
mov eax,edx
call iprintLF
call quit
