%include 'in_out.asm'

section .data
msg db "Наименьшее число: ",0
a dd 17
b dd 23
c dd 45

section .bss
min resd 1

section .text
global _start
_start:
    ; Записываем a в min
    mov eax, [a]
    mov [min], eax
    
    ; Сравниваем min и b
    cmp eax, [b]
    jl check_c
    mov eax, [b]
    mov [min], eax
    
check_c:
    ; Сравниваем min и c
    mov eax, [min]
    cmp eax, [c]
    jl finish
    mov eax, [c]
    mov [min], eax
    
finish:
    mov eax, msg
    call sprint
    mov eax, [min]
    call iprintLF
    call quit
