; in_out.asm
section .text

;------------------------------------------
; _sread - чтение строки из stdin
; ARGS: ECX = buffer, EDX = buffer size
;------------------------------------------
_sread:
    push    eax
    push    ebx
    mov     eax, 3      ; sys_read
    mov     ebx, 0      ; stdin
    int     0x80
    pop     ebx
    pop     eax
    ret

;------------------------------------------
; _swrite - запись строки в stdout
; ARGS: EAX = string pointer, EBX = string length
;------------------------------------------
_swrite:
    push    eax
    push    ebx
    push    ecx
    push    edx
    mov     ecx, eax    ; string pointer
    mov     edx, ebx    ; string length
    mov     eax, 4      ; sys_write
    mov     ebx, 1      ; stdout
    int     0x80
    pop     edx
    pop     ecx
    pop     ebx
    pop     eax
    ret

;------------------------------------------
; sprint - вывод строки
; ARGS: EAX = string pointer (null-terminated)
;------------------------------------------
sprint:
    push    ecx
    push    edx
    push    ebx
    mov     ecx, eax    ; сохраняем указатель на строку
    
    ; вычисляем длину строки
    xor     ebx, ebx    ; обнуляем счетчик
.sprint_len_loop:
    cmp     byte [eax+ebx], 0
    je      .sprint_len_done
    inc     ebx
    jmp     .sprint_len_loop
.sprint_len_done:
    
    ; выводим строку
    mov     eax, ecx
    call    _swrite
    
    pop     ebx
    pop     edx
    pop     ecx
    ret

;------------------------------------------
; sprintLF - вывод строки с переводом строки
; ARGS: EAX = string pointer
;------------------------------------------
sprintLF:
    call    sprint
    push    eax
    mov     eax, 0Ah    ; символ перевода строки
    push    eax
    mov     eax, esp    ; указатель на символ перевода строки
    mov     ebx, 1      ; длина = 1
    call    _swrite
    pop     eax
    pop     eax
    ret

;------------------------------------------
; sread - чтение строки
; ARGS: ECX = buffer, EDX = buffer size
;------------------------------------------
sread:
    call    _sread
    ret

;------------------------------------------
; iprint - вывод целого числа
; ARGS: EAX = integer
;------------------------------------------
iprint:
    push    eax
    push    ecx
    push    edx
    push    esi
    mov     ecx, 0      ; счетчик цифр
    
.divide_loop:
    inc     ecx          ; увеличиваем счетчик цифр
    mov     edx, 0       ; обнуляем edx для деления
    mov     esi, 10      ; делитель
    idiv    esi          ; eax = eax/10, edx = остаток
    add     edx, 48      ; преобразуем остаток в ASCII
    push    edx          ; сохраняем цифру в стек
    cmp     eax, 0       ; проверяем, есть ли еще цифры
    jnz     .divide_loop
    
.print_loop:
    dec     ecx          ; уменьшаем счетчик
    mov     eax, esp     ; указатель на цифру в стеке
    mov     ebx, 1       ; длина = 1
    call    _swrite      ; выводим цифру
    pop     eax          ; убираем цифру из стека
    cmp     ecx, 0       ; проверяем, все ли цифры вывели
    jnz     .print_loop
    
    pop     esi
    pop     edx
    pop     ecx
    pop     eax
    ret

;------------------------------------------
; iprintLF - вывод целого числа с переводом строки
; ARGS: EAX = integer
;------------------------------------------
iprintLF:
    call    iprint
    push    eax
    mov     eax, 0Ah    ; символ перевода строки
    push    eax
    mov     eax, esp    ; указатель на символ перевода строки
    mov     ebx, 1      ; длина = 1
    call    _swrite
    pop     eax
    pop     eax
    ret

;------------------------------------------
; atoi - преобразование строки в целое число
; ARGS: EAX = string pointer
; RET: EAX = integer
;------------------------------------------
atoi:
    push    ebx
    push    ecx
    push    edx
    push    esi
    mov     esi, eax    ; сохраняем указатель на строку
    mov     eax, 0      ; обнуляем результат
    mov     ecx, 0      ; обнуляем счетчик
    
.multiply_loop:
    xor     ebx, ebx    ; обнуляем ebx
    mov     bl, [esi+ecx] ; загружаем следующий символ
    cmp     bl, 48      ; сравниваем с '0'
    jl      .finished
    cmp     bl, 57      ; сравниваем с '9'
    jg      .finished
    cmp     bl, 10      ; проверяем на перевод строки
    je      .finished
    cmp     bl, 0       ; проверяем на конец строки
    jz      .finished
    
    sub     bl, 48      ; преобразуем символ в число
    add     eax, ebx    ; добавляем к результату
    mov     ebx, 10
    mul     ebx         ; умножаем результат на 10
    inc     ecx         ; переходим к следующему символу
    jmp     .multiply_loop
    
.finished:
    mov     ebx, 10
    div     ebx         ; делим на 10 (последнее умножение было лишним)
    
    pop     esi
    pop     edx
    pop     ecx
    pop     ebx
    ret

;------------------------------------------
; quit - завершение программы
;------------------------------------------
quit:
    mov     eax, 1      ; sys_exit
    mov     ebx, 0      ; exit code
    int     0x80
