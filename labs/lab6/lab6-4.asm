%include 'in_out.asm'
SECTION .data
msg db "Enter the value of x: ",0
rem db "Result: ",0
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
sub eax,1      
mov ebx,eax    
mul ebx         
mov ebx,5       
mul ebx         
mov edi,eax     
mov eax,rem     
call sprint
mov eax,edi
call iprintLF
call quit
