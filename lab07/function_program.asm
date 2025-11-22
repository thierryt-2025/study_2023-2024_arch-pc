%include 'in_out.asm'

section .data
msg_x db "Введите x: ",0
msg_a db "Введите a: ",0
msg_res db "Результат: ",0

section .bss
x resb 10
a resb 10

section .text
global _start
_start:
    ; Ввод x
    mov eax, msg_x
    call sprint
    
    mov ecx, x
    mov edx, 10
    call sread
    
    ; Ввод a
    mov eax, msg_a
    call sprint
    
    mov ecx, a
    mov edx, 10
    call sread
    
    ; Преобразование x из строки в число
    mov eax, x
    call atoi
    mov ebx, eax    ; ebx = x
    
    ; Преобразование a из строки в число
    mov eax, a
    call atoi
    mov ecx, eax    ; ecx = a
    
    ; Вычисление f(x)
    cmp ebx, ecx    ; Сравниваем x и a
    jge else_case   ; Если x >= a, переходим к else_case
    
    ; if x < a: f(x) = 2a - x
    mov eax, ecx    ; eax = a
    imul eax, 2     ; eax = 2a
    sub eax, ebx    ; eax = 2a - x
    jmp output
    
else_case:
    ; else: f(x) = 8
    mov eax, 8
    
output:
    ; Вывод результата
    push eax        ; Сохраняем результат
    mov eax, msg_res
    call sprint     ; Выводим "Результат: "
    pop eax         ; Восстанавливаем результат
    call iprintLF   ; Выводим число
    
    call quit
