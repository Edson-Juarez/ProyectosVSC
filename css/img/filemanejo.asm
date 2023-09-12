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
imprime macro letrero   ;Metodo que sirve para mprimmir un ensaje en pantalla
    mov ah, 09h
    LEA dx,letrero
    int 21H
endm


.model small
.stack
.data
msj db 0ah,0dh, '***** Menu *****', '$'
msj2 db 0ah,0dh, '1.- Crear Archivo', '$'
msj3 db 0ah,0dh, '2.- Abrir Archivo', '$'
msj4 db 0ah,0dh, '3.- Modificar archivo', '$'
msj5 db 0ah,0dh, '4.- Eliminar archivo', '$'
msj6 db 0ah,0dh, '5.- Salir', '$'
msj7 db 0ah,0dh, 'El Cerrado de un archivo se hace automatico', '$'
msjelim db 0ah,0dh, 'Archivo eliminado con exito', '$'
msjcrear db 0ah,0dh, 'Archivo creado con exito', '$'
msjescr db 0ah,0dh, 'Archivo escrito con exito', '$'
msjnom db 0ah,0dh, 'Nombre del archivo: ', '$'
cadena db 'Cadena a Escribir en el archivo','$'
nombre db 'archivo2.txt',0  ;nombre archivo a manejar, debe terminar en 0
vec db 50 dup('$')   ;variable a usar para la escritura del archivo.
handle db 0 ;Se cargará para la escritura de archivos, tamaño en bytes.
linea db 10,13,'$'  ;Hace un solo salto de linea
.code
Main proc 
    mov ax,@data
    mov ds,ax
    mov es,ax
inicio:


menu:
  imprime msj
  imprime msj2
  imprime msj3
  imprime msj4
  imprime msj5
  imprime msj6
  imprime msj7
  mov ah,0dh
  int 21h
 ;comparamos la opción que se tecleó
  mov ah,01h
  int 21h
  cmp al,31h
  je crear
  cmp al,32h
  je abrir
  cmp al,33h
  je pedir
  cmp al,34h
  je eliminar
  cmp al,35h
  je salir

crear:
mov ax,@data  ;Cargamos el segmento de datos para sacar el nombre del archivo.
mov ds,ax
mov ah,3ch ;instrucción para crear el archivo.
mov cx,0
mov dx,offset nombre ;crea el archivo con el nombre archivo2.txt indicado indicado en la parte .data
int 21h
jc salir ;si no se pudo crear el archivo arroja un error, se captura con jc.
imprime msjcrear
mov bx,ax
mov ah,3eh ;cierra el archivo
int 21h
jmp menu


abrir:
mov ah,3dh ;Instrucción para abrir el archivo
mov al,0h  ;0h solo lectura, 1h solo escritura, 2h lectura y escritura
mov dx,offset nombre ;abre el archivo llamado archivo2.txt indicado en .data
int 21h
mov ah,42h ;Mueve el apuntador de lectura/escritura al archivo
mov al,00h
mov bx,ax
mov cx,50 ;Decimos que queremos leer 50 bytes del archivo
int 21h  ;leer archivo
mov ah,3fh ;Lectura del archivo
mov bx,ax
mov cx,10
mov dx,offset vec
int 21h
mov ah,09h
int 21h
mov ah,3eh  ;Cierre de archivo
int 21h
jmp menu


pedir:
  mov ah,01h
  int 21h
  mov vec[si],al
  inc si
  cmp al,0dh
  ja pedir
  jb pedir

editar:;abrir el archivo
mov ah,3dh
mov al,1h ;Abrimos el archivo en solo escritura.
mov dx,offset nombre
int 21h
jc salir ;Si hubo error                      ;Escritura de archivo
mov bx,ax ; mover hadfile
mov cx,si ;num de caracteres a grabar
mov dx,offset vec
mov ah,40h
int 21h
imprime msjescr
cmp cx,ax
jne salir ;error salir
mov ah,3eh  ;Cierre de archivo
int 21h
jmp menu

eliminar:
mov ah,41h
mov dx, offset nombre
int 21h 
jc salir ;Si hubo error
imprime msjelim

salir:
mov ah,4ch ;SALIDA
    int 21h

.exit                                   ;Terminan los metodos   
main endp  
end
