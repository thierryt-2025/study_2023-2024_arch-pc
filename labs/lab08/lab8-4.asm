%include 'in_out.asm'

SECTION .data
func_msg db "Функция: f(x)=2x+15",0
result_msg db "Результат: ",0

SECTION .text
global _start

_start:
pop ecx ; Количество аргументов
pop edx ; Имя программы
sub ecx, 1 ; Убираем имя программы из счетчика

; Вывод информации о функции
mov eax, func_msg
call sprintLF

mov esi, 0 ; Сумма результатов функции

next_arg:
cmp ecx, 0 ; Проверяем, остались ли аргументы
jz print_result ; Если нет, переходим к выводу результата

pop eax ; Извлекаем аргумент
call atoi ; Преобразуем в число

; Вычисляем f(x) = 2x + 15
mov ebx, eax ; Сохраняем x в ebx
add eax, eax ; Умножаем на 2 (eax = 2x)
add eax, 15  ; Добавляем 15 (eax = 2x + 15)

add esi, eax ; Добавляем к общей сумме

loop next_arg

print_result:
mov eax, result_msg
call sprint
mov eax, esi
call iprintLF

call quit
