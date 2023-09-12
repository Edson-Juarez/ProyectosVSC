TITLE TrianguloyCirculo
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
    let1 db '      *$'
    let2 db '     * *$'
    let3 db '    *   *$'
    let4 db '   *     *$'
    let5 db '  *       *$'
    let6 db ' *         *$'
    let7 db '* * * * * * *$'

    let8 db  '         .....$'
    let9 db  '        *******$'
    let11 db '       *********$'
    let12 db '       *********$'
    let13 db '        *.*.*.*$'

.code
    Main proc 
    mov ax,@data
    mov ds,ax
    mov es,ax
    
    inicio:                             ;inicio de los metodos en orden
    limpiar                             ;Limpia la ventana de cualquier dato en el, moviendo hacia arriba lo que sea que despliegue la consola
    posicionar 0,0                      ;Se traslada a la siguiente coordenad, 
    print let1                  
    posicionar 1,0                      ;Se traslada a la siguiente coordenad, arriba der
    print let2
    posicionar 2,0                      ;Se traslada a la siguiente coordenad, arriba der
    print let3
    posicionar 3,0                      ;Se traslada a la siguiente coordenad, arriba der
    print let4
    posicionar 4,0                      ;Se traslada a la siguiente coordenad, arriba der
    print let5
    posicionar 5,0                      ;Se traslada a la siguiente coordenad, arriba der
    print let6
    posicionar 6,0                      ;Se traslada a la siguiente coordenad, arriba der
    print let7

    posicionar 7,0                      ;Se traslada a la siguiente coordenad, 
    print let8                  
    posicionar 8,0                      ;Se traslada a la siguiente coordenad, arriba der
    print let9
    posicionar 9,0                      ;Se traslada a la siguiente coordenad, arriba der
    print let11
    posicionar 10,0                      ;Se traslada a la siguiente coordenad, arriba der
    print let12
    posicionar 11,0                      ;Se traslada a la siguiente coordenad, arriba der
    print let13
    
.exit                                   ;Terminan los metodos   
main endp                                   
end main                                ;Fin del prog