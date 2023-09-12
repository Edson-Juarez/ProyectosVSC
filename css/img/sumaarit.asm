
print macro letrero
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
pedir macro
    mov ah,09h      ; imprimo en pantalla el letrero para pedir un numero
    lea dx,letrero1
    int 21h 
    mov ah,01h      ; solicito un caracter al usuario
    int 21h    
    sub al,30h      ; realizo el ajuste y lo guardo en mi primer numero
    mov n1,al    
    mov ah,09h      ; vuelvo a solicitar un digito en pantalla
    lea dx,letrero1
    int 21h                
    mov ah,01h      ; solicito un numero por teclado
    int 21h    
    sub al,30h      ; realizo el ajuste
    mov n2,al
endm
limpiar macro 
   mov ax,0600h  ;06 subir linea - recorrido al 00 pantalla completa
   mov bh,10     ;fondo,letra
   mov cx,0000h  ;renglon,columna - iniciales
   mov dx,184fh  ;renglon,columna - finales
   int 10h       ;interrupcion que llama al BIOS
    endm
.model SMALL
.386
.stack 64  
.data
  coordX db ?, '$'
  coordY db ?, '$'
  tsumar db  '1.SUMAR$'
  ltsumar equ 7
  trestar db '2.RESTAR','$'
  ltrestar equ 8
  tMULT db '3.MULTIPLICAR','$'
  lMULT equ 13
  tDIV db '4.DIVIDIR','$'
  lDIV equ 9
  tsalir db 10,13,7,'5.Salir del programa','$'
  ltsalir equ 20  
  msj2 db 10,13,7,'Adios$'
  n1 db 0 ; definimos nuestras variables, numeros de 0 a 9
  n2 db 0 ;x2
  r db 0
  letrero1 db 10,13,'Ingresa un numero de un digito: $'
  letrero2 db 10,13,'El resultado es: $'
.code
main proc far
  mov ax,@data
  mov ds,ax
  menu:       
    limpiar
    Mov ah,02h     ;funcion para posicionar cursor en pantalla
    Mov dx,0000h   ;Cursor renglon y columna
    Mov bh,00h     ;Pagina a imprimir, primer digito fondo segundo digito letras
    int 10h        ;Interrupcion      
    posicionar 0,0
    print tsumar
    posicionar 1,0
    print trestar
    posicionar 2,0
    print tMULT
    posicionar 3,0
    print tDIV
    posicionar 4,0
    print tsalir
  click:        ; label para dirigir el click del mouse
    mov ax, 01h ; funcion que activa el cursor del mouse
    int 33h     ; interrupcion para el manejo del mouse  
    mov ax, 03h ; funcion para obtener que boton del mouse fue presionado
    int 33h     ; y coordenadas
    cmp bx, 1   ; compara con 1 si es que fue presionado el btn izquierdo
    je coordenadas ; si fue presionado el btn izquierdo salta a coordenadas
    cmp bx, 2   ; si fue con click derecho salta de nuevo a la etiqueta click
    jmp click
  coordenadas:
    mov ax, cx ; el valor de las coordenadas en X (en pixeles) se guarda en cx
    mov bl,8   ; asignamos el valor de 8 a bl
    div bl     ; se divide entre 8 para obtener la posicion en pantalla donde ira
    mov coordX, al ; guarda el resultado de la division en coordX
    mov ax, dx  ; el valor de las coordenas en Y (en pixeles se guarda en DX
    mov bl,8    ; mueve a 8
    div bl      ; realiza la division: coordenadaY= pixeles/8
    mov coordY, al  ;guardalo en coordY
    cmp coordY, 0   ; si si, ve a comparar si la el cursor esta en la coordenada 0 del eje Y
    je sumar      ; si esta en 0 ve a cambiar la pantalla de suma
    cmp coordY, 1   ; si no sigue comparando con las siguientes coordenadas...
    je restar       ;se va a la pantalla de restar 
    cmp coordY, 2  ; si no sigue comparando con las siguientes coordenadas...
    je multiplicacion       ;se va a la pantalla de multiplicar
    cmp coordY, 3   ; si no sigue comparando con las siguientes coordenadas...
    je divicion       ;se va a la pantalla de dividir
    cmp coordY, 5
    je salir        ;se va a salir
    sumar:
    cmp coordx, ltsumar
    jae click
    limpiar
    pedir
    ;proceso de suma
    mov cl,n1       ; los guardo en esos registros por conviccion no por alguna norma en especifico
    mov ch,n2       ; cuando sumamos o restamos podemos usar cualquier registro las buenas practicas sugieren que siempre se usen los registros al y bl pero igual es valido usar esos    
    add ch,cl       ; ACA SE HACE LA SUMA
    mov r,ch        ; almaceno el resultado en una variable llamada r
    mov ah,09h      ; imprimo en pantalla el resultado es:
    lea dx,letrero2
    int 21h
    mov ah,02h      ; imprimo el caracter
    mov dl,r        ; que esta guardado en r
    add dl,30h      ; realizo el ajuste
    int 21h         ; interrupcion 21h
    mov ah,01h     ; espera una tecla para salir de ahi
    int 21h  
    jmp menu       ; salta para regresar al menu
    restar:
    cmp coordx, ltrestar
    jae click
    limpiar
    pedir
    ;Proceso resta
    mov cl,n1           ; guardo en cl el numero mayor
    mov ch,n2           ; guardo en ch el numero menor
    sub cl,ch           ; REALIZO LA RESTA
    mov r,cl            ; guardo el resultado en una variable llamada R
    mov ah,09h          ; imprimo en pantalla el resultado es....
    lea dx,letrero2
    int 21h
    mov ah,02h          ; funcion para imprimir un unico caracter en pantalla
    mov dl,r            ; le digo que sea r el digito a imprimir
    add dl,30h          ; realizo el ajuste para mostrarlo en pantalla
    int 21h
    mov ah,01h          ; espera una tecla para salir
    int 21h
    jmp menu 
    multiplicacion:
    cmp coordx, lMULT
    jae click
    limpiar
    pedir
    mov al,n1   ; aca por regla los guardamos en estos registros
    mov bl,n2   ; si no ensamblador no nos va a dar el resultado correcto
    mul bl      ; REALIZAMOS LA MULTIPLICACION
    mov r,al    ; guardamos el resultado que se guarda en al en la variable r
    mov ah,09h  ; Mostramos el resultado es:....
    lea dx,letrero2 
    int 21h
    mov ah,02h  ; imprimos en pantalla
    ;add r,30h  ; el caracter resultante que esta en r 
    mov dl,r    ; 
    add dl,30h  ; realizamos el ajuste en pantalla
    int 21h  
    mov ah,01h          ; espera una tecla para salir
    int 21h
    jmp menu

    
     
    divicion: 
    cmp coordx, lDIV
    jae click
    limpiar
    pedir
    mov ax,0h   ; IMPORTANTE SIEMPRE LIMPIAR EL REGISTRO AX ANTES DE HACER LA DIVISION
    mov al,n1   ; guardamos nuestros digitos en los registros al y bl
    mov bl,n2   ; es importante seguir este orden si no nos va a dar el resultado correcto
    div bl      ; REALIZO LA DIVISION
    mov cl,al   ; guardamos el resultado en el registro cl por gusto no por alguna norma que me obligue
                ; recordemos que el resultado de la division se guarda en el registro al y el mod 
                ; en el registro AH
    
    mov ah,09h  ; funcion para imprimir el resultado es:.....
    lea dx,letrero2
    int 21h
    mov ah,02h  ; imprimos nuestro resultado.... que se guardo en el registro cl
    mov dl,cl   ; le realizamos el ajuste
    add dl,30h  ; 
    int 21h      
    mov ah,01h          ; espera una tecla para salir
    int 21h
    jmp menu 
   salir:  
    cmp coordx, ltsalir
    jae click
    limpiar      
    mov ah,09h     
    mov dx, offset msj2 ; muestra en pantalla adios
    int 21h    
    mov ah,01h  ; espera una tecla para salir
    int 21h    
    mov ah,4ch  ; funcion que finaliza el programa
    int 21h    
main endp
end main
