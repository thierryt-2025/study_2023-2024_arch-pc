section .text

;---------------   slen  -------------------
; Функция вычисления длины сообщения
slen:                     
    push    ebx             
    mov     ebx, eax        
    
nextchar:                   
    cmp     byte [eax], 0   
    jz      finished        
    inc     eax             
    jmp     nextchar        
    
finished:
    sub     eax, ebx
    pop     ebx             
    ret                     

;---------------  sprint  -------------------
; Функция печати сообщения
sprint:
    push    edx
    push    ecx
    push    ebx
    push    eax
    call    slen
    
    mov     edx, eax
    pop     eax
    
    mov     ecx, eax
    mov     ebx, 1
    mov     eax, 4
    int     0x80

    pop     ebx
    pop     ecx
    pop     edx
    ret

;----------------  sprintLF  ----------------
; Функция печати сообщения с переводом строки
sprintLF:
    call    sprint

    push    eax
    mov     eax, 0AH
    push    eax
    mov     eax, esp
    call    sprint
    pop     eax
    pop     eax
    ret

;---------------  sread  ----------------------
; Функция считывания сообщения
sread:
    push    ecx
    push    edx
    mov     eax, 3
    mov     ebx, 0
    int     0x80
    pop     edx
    pop     ecx
    ret
    
;------------- iprint  ---------------------
; Функция вывода на экран чисел в формате ASCII
iprint:
    push    eax             
    push    ecx             
    push    edx             
    push    esi             
    mov     ecx, 0          
    
divideLoop:
    inc     ecx             
    mov     edx, 0          
    mov     esi, 10  
    idiv    esi    
    add     edx, 48  
    push    edx   
    cmp     eax, 0   
    jnz     divideLoop  

printLoop:
    dec     ecx       
    mov     eax, esp  
    call    sprint   
    pop     eax    
    cmp     ecx, 0   
    jnz     printLoop  

    pop     esi   
    pop     edx    
    pop     ecx   
    pop     eax           
    ret

;--------------- iprintLF   --------------------
; Функция вывода на экран чисел в формате ASCII
iprintLF:
    call    iprint          

    push    eax             
    mov     eax, 0Ah        
    push    eax             
    mov     eax, esp       
    call    sprint          
    pop     eax             
    pop     eax             
    ret

;----------------- atoi  ---------------------
; Функция преобразования ascii-код символа в целое число
atoi:
    push    ebx             
    push    ecx             
    push    edx             
    push    esi             
    mov     esi, eax        
    mov     eax, 0          
    mov     ecx, 0          
 
.multiplyLoop:
    xor     ebx, ebx        
    mov     bl, [esi+ecx]
    cmp     bl, 48 
    jl      .finished 
    cmp     bl, 57  
    jg      .finished 
    cmp     bl, 0
    je      .finished
    cmp     bl, 10
    je      .finished
 
    sub     bl, 48 
    add     eax, ebx
    mov     ebx, 10  
    mul     ebx  
    inc     ecx   
    jmp     .multiplyLoop  
 
.finished:
    cmp     ecx, 0  
    je      .restore   
    mov     ebx, 10  
    div     ebx     
 
.restore:
    pop     esi   
    pop     edx    
    pop     ecx  
    pop     ebx 
    ret

;------------- quit   ---------------------
; Функция завершения программы
quit:
    mov     ebx, 0      
    mov     eax, 1      
    int     0x80
