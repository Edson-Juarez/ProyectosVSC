.model small 
.stack ;Nos sirve como un almacen (segmento de pila) 
.data 
var1 db 5 
 var2 db 3 
 .code 
 .startup 
 mov ah, 02h    ;imprimir  variable 1
 mov dl, var1 
 add dl, 30h 
 int 21h 
 mov dl, '+'   
 int 21h 
 mov dl, var2 ;imprime variable 2
 add dl, 30h 
 int 21h 
 mov dl,'=' 
 int 21h  ;termina de imprimir
 mov ah,0h 
 mov al, var1 
 add al, var2 
 push AX ;Se guarda en la pila para no perder valores 
 mov dl,ah 
 mov ah, 02h 
 add dl, 30h 
 int 21h 
 ;pop AX ; Saca todos los valores de la pila 
 mov dl,al 
 add dl,30h 
 mov ah,02h 
 int 21h 
 .exit 
 end