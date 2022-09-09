.model small
.stack
.data
    var1 db "hola mundo", 10, 13, "$"
    var2 db "esta es la primera clase de assembler", 10, 13, "$"
    var3 db "Ingrese su nombre: ", 10, 13, "$"
    nombre db ?, "$"
.code
imprimir macro texto
    mov ah, 09
    mov dx, offset texto
    int 21h
endm

main proc
    ;movimientos al datasegment, siempre deben ir
    mov ax, @data
    mov ds, ax
    ;limpiar pantalla
    mov ah, 00h
    mov al, 03h
    int 10h
    imprimir var1
    imprimir var2
    imprimir var3
    xor si, si
Leer:
    mov ax, 00
    mov ah, 01h
    int 21h
    cmp al, 13
    jne Concatenar
    je Salir
Concatenar:
    mov nombre[si], al
    mov nombre[si + 1], "$"
    inc si
    jmp Leer
Salir:
    imprimir nombre
    ;salida del programa
    mov ax, 4c00h
    int 21h
main endp
end main