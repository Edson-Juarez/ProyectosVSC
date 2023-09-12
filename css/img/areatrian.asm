;calcular area de un triangulo base y altura dadas por el usuario
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
pedir macro
    posicionar 0,0
    print tbase 
    mov ah,01h      ; solicito un caracter al usuario
    int 21h    
    sub al,30h      ; realizo el ajuste y lo guardo en mi primer numero
    mov base,al  
    posicionar 1,0  
    print taltura               
    mov ah,01h      ; solicito un numero por teclado
    int 21h    
    sub al,30h      ; realizo el ajuste

    mov altura,al
endm
.model small
.stack
.data
    base db 0
    altura db 3
    n db 2
    resultado db 'Area del triangulo es: $'
    tbase db 'Digite la base: $'
    taltura db 'apachurre la altura: $'
.code
	main proc far
	mov ax,@data
	mov ds,ax

    inicio:
    limpiar
    pedir
    ;MULTIPLICACION BASE * ALTURA
    mov al,base         ;Aca por regla los guardamos en estos registros
    mov bl,altura       ;Si no ensamblador no nos va a dar el resultado correcto
    mul bl              ; REALIZAMOS LA MULTIPLICACION
    mov cl,al           ;Resultado se va a al para ser movido a cl para imprmimirse despues
    ;DIVISION ENTRE 2
    mov al, cl
    mov bl, n
    div bl
    mov cl,al           ;Resultado se va a al para ser movido a cl para imprmimirse despues
    posicionar 3,0
    print resultado
    mov ah,02h          ;Imprimos nuestro resultado que se guardo en el registro cl
    mov dl,cl           ; 
    add dl,30h          ;Le realizamos el ajuste 
    int 21h   

	mov ah,4ch
	int 21h
.exit
	main endp
end main