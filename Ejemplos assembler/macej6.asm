copiararreglo macro fuente, destino
    LOCAL INICIO, FIN
    xor si, si
    xor bx, bx
    INICIO:
        mov bl, cantidad
        cmp si, bx
        je FIN
        mov al, fuente[si]
        mov destino[si], al
        inc si
        jmp INICIO
    FIN:
endm

OrdenamientoDes macro
    LOCAL ordenar, verificar, resetear, fin, menor
    xor si, si
    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx
    mov dl, cantidad
    ordenar: 
        mov al, arreglotop[si]
        mov bl, arreglotop[si + 1]
        cmp ax, bx
        jl menor
        inc si
        inc cx
        cmp cx, dx
        jne ordenar
        mov cx, 0
        mov si, 0
        jmp verificar
    menor:
        mov arreglotop[si], bl
        mov arreglotop[si + 1], al
        inc si
        inc cx
        cmp dx, cx
        jne ordenar
        mov cx, 0
        mov si, 0
        jmp verificar
    verificar:
        mov al, arreglotop[si]
        mov bl, arreglotop[si + 1]
        cmp al, bl
        jl resetear
        inc si
        inc cx
        cmp cx, dx
        jne verificar
        jmp fin
    resetear:
        mov si, 0
        mov cx, 0
        jmp ordenar
    fin:
endm

OrdenamientoAsc macro
    LOCAL ordenar, verificar, resetear, fin, mayor
    xor si, si
    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx
    mov dl, cantidad
    sub dl, 1
    ordenar: 
        mov al, arreglotop[si]
        mov bl, arreglotop[si + 1]
        cmp ax, bx
        jg mayor
        inc si
        inc cx
        cmp cx, dx
        jne ordenar
        mov cx, 0
        mov si, 0
        jmp verificar
    mayor:
        mov arreglotop[si], bl
        mov arreglotop[si + 1], al
        inc si
        inc cx
        cmp dx, cx
        jne ordenar
        mov cx, 0
        mov si, 0
        jmp verificar
    verificar:
        mov al, arreglotop[si]
        mov bl, arreglotop[si + 1]
        cmp al, bl
        jg resetear
        inc si
        inc cx
        cmp cx, dx
        jne verificar
        jmp fin
    resetear:
        mov si, 0
        mov cx, 0
        jmp ordenar
    fin:
endm