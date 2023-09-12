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
    let1 db 'Ingrese un numero:$'
    num1 db 0
    let2 db 'Ingrese otro numero:$'
    num2 db 0


    ;num1 db 3                       ;numero 1 
    ;num2 db 1                       ;numero 2
    suma db 0
    resta db 0
    multiplicacion db 0
    division db 0
    msjnS db  'La suma es=  $'
    msjnR db  'La resta=  $'
    msjnM db  'La Multiplicacion es=  $'
    msjnD db  'La division es=  $' 
.code
    Main proc 
    mov ax,@data
    mov ds,ax
    mov es,ax
    ;INICIO
    ;IMPRIMIENDO EL NUMERO 1
    inicio:
    limpiar

    posicionar 0,0
    print let1                          ;Pedimos un ingreso de cadena
    introducir_num
    mov ah,02h      ; imprimo el caracter
    mov dl,num1       ; que esta guardado en num1
     
    ;IMP.NUMERO 2
    posicionar 1,0
    print let1                          ;Pedimos un ingreso de cadena
    introducir_num
    mov ah,02h      ; imprimo el caracter
    mov dl,num2       ; que esta guardado en num2
    
    

    SUM:             
    mov al,num1
    add al,num2
    mov suma,al
     
    
    REST:
    mov al,num1
    sub al,num2
    mov resta,al
    
    
    MULTIP:
    mov al,num1
    mul num2
    mov multiplicacion,al
    
    
    DIVi:
    mov al,num1
    div num2
    mov division,al
    
    

    ;Mostrar los mensajes de los resultados 
    
    ;mostrando la suma
    posicionar 2,0
    print msjnS
    mov ah,02h      ; imprimo el caracter
    mov dl,suma       ; que esta guardado en num1
    add dl,30h     ; realizo el ajuste
    int 21h  
    
    ;mostrando la resta
    posicionar 4,0
    print msjnR
    mov ah,02h      ; imprimo el caracter
    mov dl,resta       ; que esta guardado en num1
    add dl,30h      ; realizo el ajuste
    int 21h  
    
    ;mostrando la multiplicacion
    posicionar 6,0
    print msjnM
    mov ah,02h      ; imprimo el caracter
    mov dl,multiplicacion       ; que esta guardado en num1
    add dl,30h      ; realizo el ajuste
    int 21h  
    
    ;mostrando la division
    posicionar 8,0
    print msjnD
    mov ah,02h      ; imprimo el caracter
    mov dl,division       ; que esta guardado en num1
    add dl,30h      ; realizo el ajuste
    int 21h  

    fin:
    mov ah,4ch ;SALIDA
    int 21h
    RET

.exit
main endp
end main

;----------------------------------------------------------------------------------------------------------
