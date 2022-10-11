.model small
.stack
.data
    l1 db 'EJEMPLO 4', 10, 13, '$'
    l2 db 'INICIAR SESION', 10, 13, '$'
    op1 db 'F2. INICIAR SESION', 10, 13, '$'
    op2 db 'F3. SALIR', 10, 13, '$'
    msg1 db 'Ingrese el usuario:', 10, 13, '$'
    msg2 db 10, 13, 'Ingrese la contrase', 164, 'a', 10, 13, '$'
    msg3 db 10, 13, 'Ingreso al sistema', 10, 13, '$'
    msg4 db 10, 13, 'Usuario no encontrado', 10, 13, '$'
    msg5 db 10, 13, 'Contrase', 164, 'a incorrecta', 10, 13, '$'
    usering db 100 dup('$')
    passing db 100 dup('$')
    usersaved db 100 dup('$')
    passsavaed db 100 dup('$')
    tamus dw 0
    tampass dw 0
    archivo db 'ej2s', 92, 'users.txt', 0
    auxcontenidoar db 1 dup('$')
    controlusers dw 0
    controlpass dw 0
    auxiliar dw 0
    handle dw ?
.code

imprimir macro texto
    mov dx, offset texto
    mov ah, 09h
    int 21h
endm

limpiarp macro
    mov ah, 00h
    mov al, 03h
    int 21h
endm

leerusuario macro
    local e1, e2
    mov tamus, 0
    e1: 
        xor ax, ax
        mov ah, 01
        int 21h
        cmp al, 0dh
        je e2
        cmp al, 1bh
        je inicio
        mov usering[si], al
        inc si
        mov usering[si], '$'
        jmp e1
    e2:
endm

leerpass macro
    local e1, e2
    e1:
        mov ax, 00h
        mov ah, 08h
        int 21h
        cmp al, 0dh
        je e2
        cmp al, 1bh
        je inicio
        mov passing[si], al
        inc si
        mov passing[si], '$'
        mov ah, 2h
        mov dl, '$'
        int 21h
        jmp e1
    e2:
endm

calctamuser macro
    local e1, e2
    xor si, si
    mov auxiliar, 0
    e1:
        cmp usersaved[si], '$'
        je e2
        inc auxiliar
        inc si
        jmp e1
    e2:
endm

calctamuserle macro
    local e1, e2
    xor si, si
    mov tamus, 0
    e1:
        cmp usering[si], '$'
        je e2
        inc tamus
        inc si
        jmp e1
    e2:
endm

calctampasss macro
    local e1, e2
    xor si, si 
    mov auxiliar, 0
    e1:
        cmp passsavaed[si], '$'
        je e2
        inc auxiliar
        mov si, auxiliar
        jmp e1
    e2:
endm

calctampass macro
    local e1, e2
    xor si, si
    mov tampass, 0
    e1:
        cmp passing[si], '$'
        je e2
        inc tampass
        mov si, tampass
        jmp e1
    e2:
endm

main proc
    mov ax, @data
    mov ds, ax
inicio:
    imprimir l1
    imprimir op1
    imprimir op2
    mov ax, 0h
    mov ah, 0h
    int 16h
    cmp ax, 3c00h
    je imprimirl2
    cmp ax, 3d00h
    je salir
imprimirl2:
    imprimir l2
    imprimir msg1
    xor si, si
    leerusuario
    imprimir msg2
    xor si, si
    leerpass
    ;login
    ;abrir archivo de usuarios
    mov ah, 3dh
    mov al, 00h
    mov dx, offset archivo
    int 21h
    mov handle, ax
    mov bx, handle
    mov ah, 42h
    mov al, 00h
    mov cx, 0
    mov dx, 0
    int 21h
    e1:
        xor si, si
        mov controlpass, 0
        mov ah, 3fh
        mov bx, handle
        lea dx, auxcontenidoar
        mov cx, 1
        int 21h

        cmp auxcontenidoar[si], '$'
        je errornoexiste
        cmp auxcontenidoar[si], ','
        je e2
        mov al, auxcontenidoar[si]
        mov si, controlusers
        mov usersaved[si], al
        inc si
        mov controlusers, si
        mov usersaved[si], '$'
        jmp e1
    e2:
        calctamuser
        calctamuserle
        mov si, tamus
        cmp auxiliar, si
        je e3
        jne e4
    e3:
        xor si, si
    e6:
        mov al, usersaved[si]
        cmp al, '$'
        je e7
        cmp usering[si], al
        jne e4
        inc si
        jmp e6
    e4:
        mov si, 00h
        mov controlusers, 0
        mov ah, 3fh
        mov bx, handle
        lea dx, auxcontenidoar
        mov cx, 1
        int 21h
        cmp auxcontenidoar[si], 0dh
        je e5
        jmp e4
    e5:
        mov si, 00h
        mov ah, 3fh
        mov bx, handle
        lea dx, auxcontenidoar
        mov cx, 1
        int 21h
        cmp auxcontenidoar[si], '$'
        je e1
        cmp auxcontenidoar[si], 0ah
        je e5
        mov controlusers, 0
        mov al, auxcontenidoar[si]
        mov si, controlusers
        mov usersaved[si], al
        inc controlusers
        mov si, controlusers
        mov usersaved[si], '$'
        jmp e1
    e7:
        mov si, 00h
        mov ah, 3fh
        mov bx, handle
        lea dx, auxcontenidoar
        mov cx, 1
        int 21h

        cmp auxcontenidoar[si], '$'
        je errorpass
        cmp auxcontenidoar[si], 0dh
        je e8
        cmp auxcontenidoar[si], 0ah
        je e8
        mov al, auxcontenidoar[si]
        mov si, controlpass
        mov passsavaed[si], al
        inc controlpass
        mov si, controlpass
        mov passsavaed[si], '$'
        jmp e7
    e8:
        calctampasss
        calctampass
        mov si, tampass
        cmp auxiliar, si
        je e9
        jne e10
    e9:
        xor si, si
    e12:
        mov al, passsavaed[si]
        cmp al, '$'
        je ingresarsist
        cmp passing[si], al
        jne e10
        inc si
        jmp e12
    e10:
        mov si, 00h
        mov controlpass, 0
        mov ah, 3fh
        mov bx, handle
        lea dx, auxcontenidoar
        mov cx, 1
        int 21h
        cmp auxcontenidoar[si], ','
        je e11
        cmp auxcontenidoar[si], '$'
        je errorpass
        jmp e10
    e11:
        mov si, 00h
        mov ah, 3fh
        mov bx, handle
        lea dx, auxcontenidoar
        mov cx, 1
        int 21h
        cmp auxcontenidoar[si], '$'
        je errorpass
        cmp auxcontenidoar[si],','
        je e11
        mov controlpass, 0
        mov al, auxcontenidoar[si]
        mov si, controlpass
        mov passsavaed[si], al
        inc controlpass
        mov si, controlpass
        mov passsavaed[si], '$'
        jmp e7
ingresarsist:
    imprimir msg3
    jmp salir
errornoexiste:
    imprimir msg4
    jmp salir
errorpass:
    imprimir msg5
salir:
    mov ax, 4c00h
    int 21h
main endp
end main