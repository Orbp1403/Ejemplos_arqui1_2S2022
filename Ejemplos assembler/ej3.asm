.model small
.stack
.data
menuopc db 'CALCULADORA', 0DH, 0AH
db '1. SUMA', 0dh, 0AH
db '2. RESTA', 0dh, 0AH
db '3. SALIR', 0dh, 0AH
db 'DIGITE UNA OPCION: ', 0dh, 0AH, '$'
msj1 db 10, 13, 'Presione cualquier tecla para continuar',10,13,'$'
msj2 db 10, 13, 'Digite el numero 1', 10, 13, '$'
msj3 db 10, 13, 'Digite el numero 2', 10, 13, '$'
msj4 db 10, 13, 'El resultado de la operacion es: ', 10, 13, '$'
datos label byte
maxlon db 2
actlon db ?
opc db 2 dup(' ')
datos1 label byte
maxlon1 db 3
actlon1 db ?
numero1 db 3 dup(' ')
datos2 label byte 
maxlon2 db 3
actlon2 db ?
numero2 db 3 dup(' ')
resultado db 3 dup(' '), '$'
.code
menu proc near
    mov ah, 09h
    mov bh, 01
    mov cx, 174d
    lea dx, menuopc
    int 21h
    ret
menu endp

entrada proc near
    mov ah, 0AH
    lea dx, datos
    int 21h
    ret
entrada endp

imprime macro texto
    mov ah, 09
    mov dx, offset texto
    int 21h
endm

entrada_num1 proc near
    mov ah, 0ah
    lea dx, datos1
    int 21h
    ret
entrada_num1 endp

entrada_num2 proc near
    mov ah, 0ah
    lea dx, datos2
    int 21h
    ret
entrada_num2 endp

main proc
    mov ax, @data
    mov ds, ax
inicio:
    mov ah, 00h
    mov al, 03h
    int 10h
    mov dx, 0000h
    call menu
    call entrada
    cmp opc, '3'
    je salir
    imprime msj2
    call entrada_num1
    cmp actlon1, 2
    je dos_digitos_1
    mov bl, numero1
    sub bl, 30h
pedirn2:
    imprime msj3
    call entrada_num2
    cmp actlon2, 2
    je dos_digitos_2
    mov cl, numero2
    sub cl, 30h
evaluar:
    cmp opc, '1'
    je Suma
    cmp opc, '2'
    je Resta
dos_digitos_1:
    mov cl, numero1[0]
    sub cl, 30h
    mov ax, 0000
decenas:
    add al, 10
    dec cl
    cmp cl, 0
    jne decenas
    mov bx, 0000
    mov bl, al
    mov cl, numero1[1]
    sub cl, 30h
    add bl, cl
    jmp pedirn2
dos_digitos_2:
    mov cl, numero2[0]
    sub cl, 30h
    mov ax, 0000
decenas2:
    add al, 10
    dec cl
    cmp cl, 0
    jne decenas2
    mov cx, 0000
    mov cl, al
    mov al, numero2[1]
    sub al, 30h
    add cl, al
    jmp evaluar
Suma:
    add bl, cl
    imprime msj4
    cmp bl, 100
    jb Imprimir2
    cmp bl, 200
    jb Imprimir3
Resta:
    imprime msj4
    cmp bl, cl
    jb Restaneg
    sub bl, cl
    jmp Imprimir2
Restaneg:
    mov al, bl
    mov bl, cl
    mov cl, al
    mov resultado[0], '-'
    sub bl, cl
    mov ah, 00
    mov al, bl
    mov cl, 0ah
    div cl
    add ah, 30h
    mov resultado[2], ah
    add al, 30h
    mov resultado[1], al
    imprime resultado
    imprime msj1
    mov ax, 00
    mov ah, 08h
    int 21h
    mov resultado[0], ' '
    mov resultado[1] ,' '
    mov resultado[2], ' '
    jmp inicio
Imprimir2:
    mov ah, 00
    mov al, bl
    mov cl, 0ah
    div cl
    add ah, 30h
    mov resultado[1], ah
    add al, 30h
    mov resultado[0], al
    imprime resultado
    imprime msj1
    mov ax, 00
    mov ah, 08h
    int 21h
    mov resultado[0], ' '
    mov resultado[1], ' '
    jmp inicio
Imprimir3:
    mov ah, 00
    mov al, bl
    mov cl, 0ah
    div cl
    add ah, 30h
    mov resultado[2], ah
    mov ah, 00
    div cl
    add ah, 30h
    mov resultado[1], ah
    add al, 30h
    mov resultado[0], al
    imprime resultado
    imprime msj1
    mov ax, 00
    mov ah, 08h
    int 21h
    mov resultado[0], ' '
    mov resultado[1] ,' '
    mov resultado[2], ' '
    jmp inicio
salir:
    mov ax, 4c00h
    int 21h
main endp
end main