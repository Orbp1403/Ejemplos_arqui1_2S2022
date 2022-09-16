.model small
.stack
.data
    msg1 db '1. Guardar en archivo', 10, 13, "$"
    msg2 db '2. Leer archivo', 10, 13, "$"
    msg3 db '3. Salir', 10, 13, "$"
    msg4 db 'Ingrese lo que se guardara en el archivo:', 10, 13, "$"
    val db ?, "$"
    archivo db 'archivo.txt', 0
    contenido db ?, "$"
    contador dw 0
    handle dw ?
.code
;macros
imprimir macro texto
    mov ah, 09
    mov dx, offset texto
    int 21h
endm

crearF macro ruta
    mov ah, 3ch
    mov cx, 00h
    lea dx, offset ruta
    int 21h
endm

escribirF macro texto, tam
    xor ax, ax
    mov ah, 40h
    mov cx, tam
    mov dx, offset texto
    int 21h
endm

cerrarF macro
    mov ah, 3eh
    int 21h
endm

abrirF macro ruta, handle
    mov ah, 3dh
    mov al, 01h
    mov dx, offset ruta
    int 21h
    mov handle, ax
    mov bx, ax
endm

main proc
    mov ax, @data
    mov ds, ax
    mov ah, 00h
    mov al, 03h
    int 10h
Inicio:
    imprimir msg1
    imprimir msg2
    imprimir msg3
Leer:
    mov ax, 00
    mov ah, 01h
    int 21h
    xor si, si
    cmp al, 49
    je Guardar
    ;cmp al, 50
    ;je Leer
    jne Salir
Guardar:
    imprimir msg4
Guardar2:
    mov ax, 00
    mov ah, 01h
    int 21h
    cmp al, 13
    je Guardar1
    jne Concatenar
Guardar1:
    crearF archivo
    cerrarF
    abrirF archivo, handle
    escribirF contenido, si
    cerrarF
    jmp Salir
Concatenar:
    cmp al, 27
    je Inicio
    mov contenido[si], al
    mov contenido[si + 1], "$"
    inc si
    jmp Guardar2
Salir:
    imprimir contenido
    mov ax, 4c00h
    int 21h
main endp
end main