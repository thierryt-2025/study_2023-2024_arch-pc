%include 'in_out.asm'

SECTION .data
msg db "Результат: ",0

SECTION .text
global _start

_start:
pop ecx ; Извлекаем количество аргументов
pop edx ; Извлекаем имя программы
sub ecx,1 ; Уменьшаем количество аргументов на 1
mov esi, 0 ; Используем `esi` для хранения суммы

next:
cmp ecx,0h ; проверяем, есть ли еще аргументы
jz _end ; если аргументов нет выходим из цикла
pop eax ; извлекаем следующий аргумент из стека
call atoi ; преобразуем символ в число
add esi,eax ; добавляем к сумме
loop next ; переход к следующему аргументу

_end:
mov eax, msg ; вывод сообщения "Результат: "
call sprint
mov eax, esi ; записываем сумму в регистр `eax`
call iprintLF ; печать результата
call quit ; завершение программы
