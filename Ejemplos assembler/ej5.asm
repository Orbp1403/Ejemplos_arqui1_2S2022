.model small
.stack
.data
    l1      db 'EJEMPLO 5', 10, 13, '$'
    user    db 'oscar', '$'
    ;COORDENADAS DEL BLOQUE
    xbloque dw 0
    ybloque dw 0
    ;MARCO
    lineamarco db 20 dup(24)
    lineamarco1 db 24, 24
    ;BLOQUE
    bloqueFila1 db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15
    bloqueFila2 db 15, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 15
    bloqueFila3 db 15, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 15
    bloqueFila4 db 15, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 15
    bloqueFila5 db 15, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 15
    bloqueFila6 db 15, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 15
    bloqueFila7 db 15, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 15
    bloqueFila8 db 15, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 15
    bloqueFila9 db 15, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 15
    bloqueFila10 db 15, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 15
    bloqueFila11 db 15, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 15
    bloqueFila12 db 15, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 15
    bloqueFila13 db 15, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 15
    bloqueFila14 db 15, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 15
    bloqueFila15 db 15, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 15
    bloqueFila16 db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15

.code
limpiarpantallag proc
;vuelve a entrar al modo video
    mov ah, 0
    mov al, 13h
    int 10h
    ret
limpiarpantallag endp

imprimirnombre macro
    local e1, e2
    mov dl, 0
    e1:
    ;editar la posicion del cursor
        mov ah, 02h
        ;dh fila
        mov dh, 0
        ;dl columna
        mov dl, dl
        int 10h
        mov dx, offset user
        mov ah, 09h
        int 21h
    e2:
endm

auxdiblinea macro vector, tam
;movemos a di la posicion en la que se va a dibujar
    mov di, ax
    mov si, offset vector
    mov cx, tam
    rep movsb
endm

dibujarmarco macro
    local e1, e2, e3, e4, e5
    ;convertir las coordenadas para linealizar
    ;multiplicar por 320 la posicion en y y sumar la posicion en x
    mov cx, 320
    mul cx
    add ax, bx
    mov di, ax
    e1:
        ;empezar a dibujar el marco
        auxdiblinea lineamarco, 20 ;0
        add ax, 20
        auxdiblinea lineamarco, 20 ; 20
        add ax, 20
        auxdiblinea lineamarco, 20 ;40
        add ax, 20
        auxdiblinea lineamarco, 20;60
        add ax, 20
        auxdiblinea lineamarco, 20;80
        add ax, 20
        auxdiblinea lineamarco, 20;100
        add ax, 20
        auxdiblinea lineamarco, 20;120
        add ax, 20
        auxdiblinea lineamarco, 20;140
        add ax, 20
        auxdiblinea lineamarco, 20;160
        add ax, 20
        auxdiblinea lineamarco, 20;180
        add ax,140 ;ax = 320
        auxdiblinea lineamarco, 20 ;320
        add ax, 20
        auxdiblinea lineamarco, 20 ; 340
        add ax, 20
        auxdiblinea lineamarco, 20 ;360
        add ax, 20
        auxdiblinea lineamarco, 20;380
        add ax, 20
        auxdiblinea lineamarco, 20;80
        add ax, 20
        auxdiblinea lineamarco, 20;100
        add ax, 20
        auxdiblinea lineamarco, 20;120
        add ax, 20
        auxdiblinea lineamarco, 20;140
        add ax, 20
        auxdiblinea lineamarco, 20;160
        add ax, 20
        auxdiblinea lineamarco, 20;180
        add ax, 140
        auxdiblinea lineamarco1, 2
        push ax
        xor si, si
    e2:
        push si
        add ax, 320
        auxdiblinea lineamarco1, 2
        pop si
    e3:
        inc si
        cmp si, 170
        jne e2

        pop ax
        add ax, 198
        auxdiblinea lineamarco1, 2
        xor si, si
    e4:
        push si
        add ax, 320
        auxdiblinea lineamarco1, 2
        pop si
    e5:
        inc si
        cmp si, 170
        jne e4

        sub ax, 198
        auxdiblinea lineamarco, 20 ;0
        add ax, 20
        auxdiblinea lineamarco, 20 ; 20
        add ax, 20
        auxdiblinea lineamarco, 20 ;40
        add ax, 20
        auxdiblinea lineamarco, 20;60
        add ax, 20
        auxdiblinea lineamarco, 20;80
        add ax, 20
        auxdiblinea lineamarco, 20;100
        add ax, 20
        auxdiblinea lineamarco, 20;120
        add ax, 20
        auxdiblinea lineamarco, 20;140
        add ax, 20
        auxdiblinea lineamarco, 20;160
        add ax, 20
        auxdiblinea lineamarco, 20;180
        add ax,140 ;ax = 320
        auxdiblinea lineamarco, 20 ;320
        add ax, 20
        auxdiblinea lineamarco, 20 ; 340
        add ax, 20
        auxdiblinea lineamarco, 20 ;360
        add ax, 20
        auxdiblinea lineamarco, 20;380
        add ax, 20
        auxdiblinea lineamarco, 20;80
        add ax, 20
        auxdiblinea lineamarco, 20;100
        add ax, 20
        auxdiblinea lineamarco, 20;120
        add ax, 20
        auxdiblinea lineamarco, 20;140
        add ax, 20
        auxdiblinea lineamarco, 20;160
        add ax, 20
        auxdiblinea lineamarco, 20;180
endm

GetChar proc
    xor ah, ah
    int 16h
    ret
GetChar endp

VSync proc
;metodo de sincronizacion vertical de pantalla
    mov dx, 03dah
    WaitNotVSync:
        in al, dx
        and al, 08h
        jnz WaitNotVSync
    WaitVSync:
        in al, dx
        and al, 08h
        jz WaitVSync
    ret
VSync endp

Delay proc
;agregar un delay en microsegundos para refrescar la pantalla
;los microsegundos se toman como cx:dx
    mov cx, 00001h
    mov dx, 0000h
    mov ah, 86h
    int 15h
    ret
Delay endp

HasKey proc
    push ax
    mov ah, 00001h
    int 16h
    pop ax
    ret 
HasKey endp

dibujarbloque macro
    mov cx, 320
    mul cx
    add ax, bx
    mov di, ax
    auxdiblinea bloqueFila1, 16
    add ax, 320
    auxdiblinea bloqueFila2, 16
    add ax, 320
    auxdiblinea bloqueFila3, 16
    add ax, 320
    auxdiblinea bloqueFila4, 16
    add ax, 320
    auxdiblinea bloqueFila5, 16
    add ax, 320
    auxdiblinea bloqueFila6, 16
    add ax, 320
    auxdiblinea bloqueFila7, 16
    add ax, 320
    auxdiblinea bloqueFila8, 16
    add ax, 320
    auxdiblinea bloqueFila9, 16
    add ax, 320
    auxdiblinea bloqueFila10, 16
    add ax, 320
    auxdiblinea bloqueFila11, 16
    add ax, 320
    auxdiblinea bloqueFila12, 16
    add ax, 320
    auxdiblinea bloqueFila13, 16
    add ax, 320
    auxdiblinea bloqueFila14, 16
    add ax, 320
    auxdiblinea bloqueFila15, 16
    add ax, 320
    auxdiblinea bloqueFila16, 16
    add ax, 320
endm

moverabajo macro
    push ax
    mov ax, ybloque
    cmp ax, 100
    je inicio1
    inc ax
    mov ybloque, ax
    pop ax
endm

main proc
    mov ax, @data
    mov ds, ax
    ;entrar al modo grafico
    ; ah = 0
    ; al = 13h
    ; RESOLUCION 320X200 CON 256 COLORES
    xor ax, ax
    mov ax, 13h
    int 10h
    ;offset de la memoria de video 
    mov ax, 0A000h
    mov es, ax
    ;coordenadas del bloque
    mov xbloque, 125
    mov ybloque, 23
inicio:
    call limpiarpantallag
    push ax
    push bx
    imprimirnombre
    ;dibujar marco
    mov ax, 20 ;posicion y
    mov bx, 50 ;posicion x
    dibujarmarco
    moverabajo
inicio1:
    mov ax, ybloque
    mov bx, xbloque
    dibujarbloque
    pop bx
    pop ax
    call VSync
    call VSync
    call Delay
    call HasKey
    jz inicio
    call GetChar ;verificar teclas
    cmp al, 20h ;espacio
    je fin
    cmp ax, 4b00h;flecha izquierda
    je moverizq
    cmp ax, 4d00h;flecha derecha
    je moverder
    jmp inicio
moverizq:
    push ax
    mov ax, xbloque
    cmp ax, 52; esto para ver si se puede mover a la izquierda
    je inicio
    dec ax
    mov xbloque, ax
    pop ax
    jmp inicio
moverder:
    push ax
    mov ax, xbloque
    cmp ax, 180; esto para ver si se puede mover a la derecha
    je inicio
    inc ax
    mov xbloque, ax
    pop ax
    jmp inicio
fin:
    ;regresar el control de la pantalla al modo texto
    mov ax, 3h
    int 10h
    ;mov ax, 4c00h
    mov ah, 4ch
    xor al, al
    int 21h
main endp
end main