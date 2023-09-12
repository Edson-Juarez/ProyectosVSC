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
print macro letrero
          mov ah, 09h
          LEA dx,letrero
          int 21H
endm
introducir_num macro          ;Sirve para introducir caracteres en cadena
    mov ah, 01h
    int 21H
    
    mov valor1, al

    mov ah, 01h
    int 21H
    
    mov valor2, al

    mov ah, 01h
    int 21H
    
    mov valor3, al
    endm
;----------------------------------------------------------------------------------------------------->"(-Valor2+7-valor3+valor1)" 

.model small
.stack
.data
    valor1 db 0
    valor2 db 0
    valor3 db 0
    siete db 7
    menosuno db -1
    r db 0
    let1 db 'Ingrese un numero:$'
    let2 db 'Ingrese otro numero:$'
    letrero db 'Resultado: $'
.code
	main proc far
	mov ax,@data
	mov ds,ax
    limpiar
    posicionar 0,0
    print let1                          ;Pedimos un ingreso de cadena
    introducir_num
    mov ah,02h      ; imprimo el caracter
    mov dl,valor1       ; que esta guardado en num1
    ;IMP.NUMERO 2
    posicionar 1,0
    print let2                          ;Pedimos un ingreso de cadena
    introducir_num
    mov ah,02h      ; imprimo el caracter
    mov dl,valor2       ; que esta guardado en num2
    ;IMP.NUMERO 2
    posicionar 2,0
    print let2                          ;Pedimos un ingreso de cadena
    introducir_num
    mov ah,02h      ; imprimo el caracter
    mov dl,valor3       ; que esta guardado en num2
    posicionar 3,0 
    ;-1 * valor2
    mov al,valor2       ; aca por regla los guardamos en estos registros
    mov bl,menosuno     ; si no ensamblador no nos va a dar el resultado correcto
    mul bl              ; REALIZAMOS LA MULTIPLICACION
    mov valor2,al            ; guardamos el resultado que se guarda en al en la variable valor2, valor2 -> -1 * valor2

    ;-valor2 + 7
    mov cl,valor2       ; los guardo en esos registros por conviccion no por alguna norma en especifico
    mov ch,siete        ; cuando sumamos o restamos podemos usar cualquier registro las buenas practicas sugieren que siempre se usen los registros al y bl pero igual es valido usar esos    
    add ch,cl           ; ACA SE HACE LA SUMA
    mov siete,ch            ; almaceno el resultado en una variable llamada siete

    ;-valor2 + 7 - valor3 -> -valor2 + 7 el resultado esta guardado en la variable 7 
    mov cl,siete            ; guardo en cl el numero mayor
    mov ch,valor3           ; guardo en ch el numero menor
    sub cl,ch               ; REALIZO LA RESTA
    mov valor3,cl            ; guardo el resultado en una variable llamada valor3

    ;todo lo demas + valor1, el resultado de las variables anteriores se quedo guardado en valor3 > -valor2 + 7 - valor3 
    mov cl,valor3       ; los guardo en esos registros por conviccion no por alguna norma en especifico
    mov ch,valor1       ; cuando sumamos o restamos podemos usar cualquier registro las buenas practicas sugieren que siempre se usen los registros al y bl pero igual es valido usar esos    
    add ch,cl       ; ACA SE HACE LA SUMA
    mov r,ch        ; almaceno el resultado en una variable llamada r, las operaciones al final quedan en r > -valor2 + 7 - valor3 + valor1
    
    mov al,r
    print letrero
    
    aam                 ;Ajuste al registro AX, separa el numero para poder manipularlo una oarte la manda a AH y otra a AL
    mov bx,ax           ;Lo que hay en AX, lo mueve a BX para guardar el resultado y que no se pierda
    add bx,3030h       ;Se realiza el ajuste para poder mostrar un numero en pantalla

    mov ah,02h          
    mov dl,bh           ;IMPRIME LO QUE HAY EN BH
    int 21h

    mov ah,02h

    mov dl,bl           ;IMPRIME LO QUE HAY EN BL
    int 21h

    mov ah,02h
    mov dl,' '
    int 21h

    ;SALIR
	mov ah,4ch
	int 21h

.exit
	main endp
end main