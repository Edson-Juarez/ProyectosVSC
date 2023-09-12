print macro letrero
          mov ah, 09h
          LEA dx,letrero
          int 21H
endm
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
leer_c macro
           mov ah,01h
           int 21h
endm
.model small
.stack
.data
    z db 'z$'
.code
	main proc far
	mov ax,@data
	mov ds,ax
    limpiar
    posicionar 0,0

    for:
    mov ah,09h 
    mov al,122
    mov bh,0
    mov bl,7 ; color
    mov cx,2000
    int 10h    
    posicionar 24,84      
    leer_c 
    cmp al, 27
    je salir
    jmp for  

    salir:
	mov ah,4ch
	int 21h
.exit
	main endp
end main