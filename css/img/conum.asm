TITLE EJEMPLO
.286
print macro letrero         ;Metodo para impresión de una cadena
    mov ah, 09h
    mov bh,10 
    LEA dx,letrero
    int 21H
endm
posicionar macro x,y  
    mov ah,02h      ;llamamos a la funcion 02h
    mov bh,00       ;
    mov dh,x
    mov dl,y
    int 10h
endm
limpiar macro    ;Limpieza de la pantalla de consola
   mov ax,0600h  ;06 subir linea - recorrido al 00 pantalla completa
   mov bh,10     ;fondo,letra
   mov cx,0000h  ;renglon,columna - iniciales
   mov dx,184fh  ;renglon,columna - finales
   int 10h       ;interrupcion que llama al BIOS
    endm
model small ; medium, large
.stack
.data
    num1 db 3                       ;numero 1 
    num2 db 1                       ;numero 2
    cad3 db 'SON IGUALES$'          ;Cadena =
    cad4 db 'Primero es mayor$'     ;Cadena >
    cad5 db 'Segundo es mayor$'     ;Cadena <
.code
    Main proc 
    mov ax,@data
    mov ds,ax
    ;INICIO
    ;IMPRIMIENDO EL NUMERO 1
    inicio:
    limpiar
    posicionar 0,0
    mov ah,02h      ; imprimo el caracter
    mov dl,num1       ; que esta guardado en num1
    add dl,30h      ; realizo el ajuste
    int 21h  
    ;IMP.NUMERO 2
    posicionar 1,0
    mov ah,02h      ; imprimo el caracter
    mov dl,num2       ; que esta guardado en num2
    add dl,30h      ; realizo el ajuste
    int 21h  
    ;COMPARANDO     
    mov al, num1
    mov bl, num2
    cmp al,bl
    je igual  ;iguales
    jg esmayor ;primero es mayor
    jl esmenor ;segundo es mayor

    igual:
    posicionar 2,0
    print cad3
    jmp fin
    
    esmayor:
    posicionar 2,0
    print cad4
    jmp fin

    esmenor:
    posicionar 2,0
    print cad5
    jmp fin
    
    fin:
    mov ah,4ch ;SALIDA
    int 21h
    RET
.exit
main endp
end main