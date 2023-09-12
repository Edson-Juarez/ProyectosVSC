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

   introducir_num macro          ;Sirve para introducir caracteres en cadena
    mov ah, 01h
    int 21H
    
    mov num1, al

    mov ah, 01h
    int 21H
    
    mov num2, al
    endm



model small ; medium, large
.stack
.data
    
    num1 db 8    
    num2 db -15
    num3 db 20


    ;num1 db 3                       ;numero 1 
    ;num2 db 1                       ;numero 2
    suma  db 0
    resta db 0
    sumau db 0
    msjnM db 'La operacion es=  $'
    msjn db  '  $'
.code
    Main proc 
    mov ax,@data
    mov ds,ax
    mov es,ax
    ;INICIO
    ;IMPRIMIENDO EL NUMERO 1
    inicio:
    limpiar

    SUM:       
    not num2    
    mov al,num2
    add al,07
    mov suma,al
     
    
    REST:
    mov al,suma
    sub al,num3
    mov resta,al
    
    SUM1:             
    mov al,resta
    add al,num1
    mov sumau,al
    
    ;mostrando la suma ult
    posicionar 0,3
    print msjnM
    mov ah,02h      ; imprimo el caracter
    mov dl,sumau       ; que esta guardado en num1
    add dl,38h      ; realizo el ajuste
    int 21h  
    
    posicionar 3,0
    print msjn

    fin:
    mov ah,4ch ;SALIDA
    int 21h
    RET

.exit
main endp
end main

;----------------------------------------------------------------------------------------------------------
