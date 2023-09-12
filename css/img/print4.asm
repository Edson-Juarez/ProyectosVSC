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
    let1 db 'Juarez L Edson Ruben$'
.code
    Main proc 
    mov ax,@data
    mov ds,ax
    mov es,ax
    
    inicio:                             ;inicio de los metodos en orden
    limpiar                             ;Limpia la ventana de cualquier dato en el, moviendo hacia arriba lo que sea que despliegue la consola
    posicionar 0,0                      ;Se traslada a la siguiente coordenad, 
    print let1                         
    posicionar 0,39h                      ;Se traslada a la siguiente coordenad, arriba der
    print let1
    posicionar 17h,0                      ;Se traslada a la siguiente coordenad, 
    print let1
    posicionar 17h,39h                      ;Se traslada a la siguiente coordenad, 
    print let1
.exit                                   ;Terminan los metodos   
main endp                                   
end main                                ;Fin del programa