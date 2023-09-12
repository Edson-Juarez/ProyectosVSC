TITLE EJEMPLO
.286
limpiar macro 
   mov ax,0600h  ;06 subir linea - recorrido al 00 pantalla completa
   mov bh,10     ;fondo,letra
   mov cx,0000h  ;renglon,columna - iniciales
   mov dx,184fh  ;renglon,columna - finales
   int 10h       ;interrupcion que llama al BIOS
    endm
posicionar macro x,y  
    mov ah,02h      ;llamamos a la funcion 02h
    mov bh,00       ;
    mov dh,x
    mov dl,y
    int 10h
endm
print macro letrero   ;Metodo que sirve para mprimmir un ensaje en pantalla
    mov ah, 09h
    LEA dx,letrero
    int 21H
endm
introducir_cadena macro cadena          ;Sirve para introducir caracteres en cadena
    mov ah, 3fh
    mov bx, 00
    mov cx, 5
    LEA dx,cadena
    int 21h
endm
model small                                 
.stack
.data
    titulo db 'Captura de cadena$'      ;Desplegamos instrucciones en pantalla
    let1 db 'Ingrese una cadena:$'
    origen db 10 dup (?),'$'
.code
    Main proc 
    mov ax,@data
    mov ds,ax
    mov es,ax
    
    inicio:                             ;inicio de los metodos en orden
    limpiar                             ;Limpia la ventana de cualquier dato en el, moviendo hacia arriba lo que sea que despliegue la consola
    posicionar 0,0                      ;Nos situamos en las coordenadas de la pantalla para asi empezar a imprimir las instrucciones
    print titulo                        ;Imprime la cadena titulo
    posicionar 1,0                      ;Se traslada a la siguiente coordenad, puede suponerse un salto de linea
    print let1                          ;Pedimos un ingreso de cadena
    introducir_cadena origen            ;Nos permite ingresar una cadena
    posicionar 2,0                      ;Salto de Linea    
    print origen                        ;Imprime la cadena que introducimos anteriormente
.exit                                   ;Terminan los metodos   
main endp                                   
end main                                ;Fin del programa