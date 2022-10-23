include macej6.asm
.model small
.stack
.data
    arreglotop db 10, 50, 45, 20, 80, 98, 25, 25, 30, 35
    auxarreglo db 10 dup(0)
    cantidad   db 10
.code

GetChar proc
    xor ah, ah
    int 16h
    ret
GetChar endp

main proc
    mov ax, @data
    mov ds, ax
    copiararreglo arreglotop, auxarreglo
    OrdenamientoDes
    copiararreglo auxarreglo, arreglotop
    OrdenamientoAsc
    mov ax, 13h
    int 10h
    mov ax, 0A000h
    mov es, ax
    xor ax, ax

    ;modo para pintar un pixel
    mov ah, 0ch
    mov al, 44 ; color
    mov cx, 10 ; posicion en x
    mov dx, 10 ; posicion en y
    int 10h
    pintar:
        inc cx ; hacer la barra mas larga
        int 10h
        cmp cx, 100
        jne pintar
    inc dx ; hacer la barra mas gruesa
    mov cx, 10
    cmp dx, 20
    jne pintar
    call GetChar
    mov ax, 0003h
    int 10h
    fin:
        xor ax, ax
        mov ah, 4ch
        int 21h
main endp
end main