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
.model small
.stack
.data
    cal  db 7
    cal2 db 8
    cal3 db 7
    cal4 db 9
    cal5 db 10
    cal6 db 8
    cal7 db 9
    cal8 db 8
    suma db 0
    n db 8
    resultado db 'Promedio es: $'
.code
	main proc far
	mov ax,@data
	mov ds,ax

    inicio:
    limpiar             ;mando a llamar la macro limpiar
    ;SUMAS
    mov cl,cal          
    mov ch,cal2
    add cl,ch           ;Suma de cal + cal2
    mov suma, cl

    mov cl,cal3
    mov ch,cal4
    add cl,ch           ;Suma de cal3 + cal4
    mov suma, cl

    mov cl,cal5
    mov ch,cal6
    add cl,ch           ;Suma de cal5 + cal6
    mov suma, cl

    mov cl,cal7
    mov ch,cal8
    add cl,ch           ;Suma de cal7 + cal8
    mov suma, cl
    ;DIVISION
    mov al,suma
    mov bl,n
    div bl              ;Division suma / n osea las calificaciones sumadas / 8 
    aad
    mov cl,al           ;Resultado se va a al para ser movido a cl para imprmimirse despues
    posicionar 0,0
    print resultado
    mov ah,02h          ;Imprimos nuestro resultado que se guardo en el registro cl
    mov dl,cl           ; 
    add dl,30h          ;Le realizamos el ajuste 
    int 21h   
	mov ah,4ch          ;Salir
	int 21h
.exit
	main endp
end main