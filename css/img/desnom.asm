TITLE HolaMundo
.286
limpiar macro 
   mov ax,0600h  ;06 subir linea - recorrido al 00 pantalla completa
   mov bh,10     ;fondo,letra
   mov cx,0000h  ;renglon,columna - iniciales
   mov dx,184fh  ;renglon,columna - finales
   int 10h       ;interrupcion que llama al BIOS
    endm
model small 
.stack
.data
    cad db 'Juarez Lucas Edson Ruben$'  ;Cadena a imprimir
.code
    Main proc                       
    mov ax,@data
    mov ds,ax
    limpiar
    mov ah, 09h
    LEA dx, cad
    int 21H
.exit
main endp
end main