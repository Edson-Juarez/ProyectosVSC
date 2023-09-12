;Realizar un programa que calcule el minimo comun multiplo y el maximo comun divisor de 2 numeros 
print macro letrero
          mov ah, 09h
          LEA dx,letrero
          int 21H
endm
limpiar macro
            mov ax,0600h    ;06 subir linea - recorrido al 00 pantalla completa
            mov bh,1000B      ;fondo,letra
            mov cx,0000h    ;renglon,columna - iniciales
            mov dx,184fh    ;renglon,columna - finales
            int 10h         ;interrupcion que llama al BIOS
endm
posicionar macro x,y
               mov ah,02h    ;llamamos a la funcion 02h
               mov bh,00
               mov dh,x
               mov dl,y
               int 10h
endm
.model small

.stack

.data

    letreroMCM db 'Minimo comun multiplo: $'    ;Mensaje
    letreroMCD db 'Maximo comun divisor:  $'    ;Mensaje
    cont db 1                                   ;cont = contador
    MCM db 0                                    ;en esta variable se guarda el MCM
    MCD db 0                                    ;en esta variable se guarda el MCD
    nro1 db 4                                   ;numero1 decimal
    nro2 db 9                                   ;numero2 decimal

.code
	main proc far
	mov ax,@data
	mov ds,ax
    limpiar
    bucle:
    mov ah,0
    mov al,cont
    mov bl,nro1
    div bl
    cmp ah,0 ;si el resto de la division del contador con el nro1 es igual 0
    je parte1

    bc:
    inc cont ;incrementar el contador
    jmp bucle ;bucle hasta que encuentre el MCM
 
    parte1: ;si nro1 es multiplo del contador
    mov ah,0
    mov al,cont
    mov bl,nro2
    div bl
    cmp ah,0 ;compara si el resto de la division del contador con el nro2 es 0
    je parte2
    jmp bc ;si el nro2 no es multiplo del contador regresa a bucle1

    parte2: ;si el nro1 y el nro2 son multiplos del contador
    mov al,cont
    mov MCM,al ;guarda el MCM
    jmp parte3 ;ir a final
 
    parte3: ;una vez que tengamos el MCM primero multiplicar nro1 * nro 2
    mov al, nro1 ;con ese resultado, dividir por el MCM de nro1 y nro2 y tenemos el MCD
    mov bl, nro2
    mul bl
    mov bl, MCM
    div bl
    mov MCD, al
    posicionar 0,0
    print letreroMCD
    mov ah,02h      ; imprimo el caracter
    mov dl,MCD        ; que esta guardado en r
    add dl,30h      ; realizo el ajuste
    int 21h         ; interrupcion 21h
    posicionar 1,0
    print letreroMCM
    mov ah,02h      ; imprimo el caracter
    mov dl, MCM        ; que esta guardado en r
    add dl,30h      ; realizo el ajuste
    int 21h         ; interrupcion 21h
    
	mov ah,4ch
	int 21h
.exit
	main endp
end main