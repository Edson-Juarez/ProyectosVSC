limpiar macro
            mov ax,0600h    ;06 subir linea - recorrido al 00 pantalla completa
            mov bh,10       ;fondo,letra
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
print macro letrero   ;Metodo que sirve para mprimmir un ensaje en pantalla
    mov ah, 09h
    LEA dx,letrero
    int 21H
endm
.model small
.stack
.data
let1 db '=================$'
let2 db 'II             II$'
.code
	main proc far
	mov ax,@data
	mov ds,ax
    mov es,ax
    limpiar

    posicionar 0,0                      ;Se traslada a la siguiente coordenad, 
    print let1                  
    posicionar 1,0                      ;Se traslada a la siguiente coordenad, arriba der
    print let2
    posicionar 2,0                      ;Se traslada a la siguiente coordenad, arriba der
    print let2
    posicionar 3,0                      ;Se traslada a la siguiente coordenad, arriba der
    print let2
    posicionar 4,0                      ;Se traslada a la siguiente coordenad, arriba der
    print let2
    posicionar 5,0                      ;Se traslada a la siguiente coordenad, arriba der
    print let2
    posicionar 6,0                      ;Se traslada a la siguiente coordenad, arriba der
    print let1

    posicionar 3,6
    ;Diagonal de colores
    mov ah, 09h 
    mov al,69
    mov bh,0
    mov bl,5 ; color
    mov cx,1
    int 10h
    posicionar 3,7
    mov ah, 09h 
    mov al,68
    mov bh,0
    mov bl,6 ; color
    mov cx,1
    int 10h
    posicionar 3,8
    mov ah, 09h 
    mov al,83
    mov bh,0
    mov bl,8 ; color
    mov cx,1
    int 10h
    posicionar 3,9
    mov ah, 09h 
    mov al,79
    mov bh,0
    mov bl,2 ; color
    mov cx,1
    int 10h
    posicionar 3,10
    mov ah, 09h 
    mov al,78
    mov bh,0
    mov bl,3 ; color
    mov cx,1
    int 10h




    posicionar 7,7
    mov ah, 09h 
    mov al,78
    mov bh,0
    mov bl,0 ; color
    mov cx,1
    int 10h
    
    ;Salir
    mov ah,4ch 
	int 21h
.exit
	main endp
end main