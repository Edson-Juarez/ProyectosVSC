imprime MACRO cadena
 MOV AX, data
 MOV DS,AX
 MOV AH,09h
 MOV DX,OFFSET cadena
 INT 21H
ENDM

 .model small
 .stack
 .data 
msj1  DB 0AH, 0DH, '  Menu ','$'
msj2  DB 0AH, 0DH, '1.- Crear archivo','$'
msj3  DB 0AH, 0DH, '2.- Abrir archivo','$'
msj4  DB 0AH, 0DH, '3.- Modificar archivo','$'
msj5  DB 0AH, 0DH, '4.- Eliminar archivo','$'
msj6  DB 0AH, 0DH, '5.- Salir','$'
msj7  DB 0AH, 0DH, 'Elegir opcion','$' 
msjelim  DB 0AH, 0DH, 'Archivo eliminado con exito','$'
msjcrear DB 0AH, 0DH, 'Archivo creado con exito','$'
msjescr  DB 0AH, 0DH, 'Archivo escrito con exito','$'
msjnom   DB 0AH, 0DH, 'Nombre del archivo:','$'
cadena DB '  ','$'
nombre DB 'Ejemplo_texto.txt',0
vec  DB 50 DUP('$')
imp  DB 50 DUP('$')
handle DB 0
linea DB 10,13,'$'
.code
inicio:

menu:
 imprime msj1
 imprime msj2
 imprime msj3
 imprime msj4
 imprime msj5
 imprime msj6
 imprime msj7
 
 MOV  AH,0DH
 INT  21H
 ;compramos la opcion que se teclea
 MOV  AH,01H
 INT  21H
 CMP  AL,31H
 JE  crear
 CMP  AL,32H
 JE  abrir
 CMP  AL,33H
 JE  pedir
 CMP  Al,34H
 JE  eliminar
 CMP  Al,35H
 JE  salir
 
crear:
 MOV  AX,@data
 MOV  DS,AX 
 ;creaar
 MOV  AH,3CH
 MOV  CX,0
 MOV  DX,OFFSET nombre
 INT  21H
 JC  salir; si no se pudo crear
 imprime msjcrear 
 MOV  BX,AX
 MOV  AH,3EH; cierr EL archivo
 INT  21H
 JMP  menu
   
abrir:
;abrir
 MOV  AH,3DH 
 MOV AL,0H;0H SOLO LECTURA,1H SOLO ESCRITURA, 2H LECTURA Y ESCRITURA
 MOV  DX,OFFSET nombre                                              
 INT  21H
 MOV  AH,42H
 MOV AL,00H
 MOV BX,AX
 MOV  CX,50
 INT 21H
 ;LEER ARCHIVO
 MOV AH,3FH
 ;MOV BX,AX
 MOV BX,AX
 MOV CX,10
 MOV SI,00H
 MOV DX,OFFSET IMP
 MOV DL,IMP[SI]
 INT 21H
 MOV AH,09H
 INT 21H
 
 ;CIERRE DE ARCHIVO
 MOV AH,3EH
 INT 21H
 JMP MENU
 
 
pedir:
 MOV  AH,01H
 INT  21H
 MOV  vec[SI],AL
 INC  SI
 CMP  AL,0DH
 JA  pedir
 JB  pedir
 
editar:
 MOV  AH,3DH ;ABRIR
 MOV  AL,01H
 MOV  DX,OFFSET nombre
 INT  21H
 
 MOV  BX,AX  ;GUARDA EL HANDLE
 MOV  CX,SI  ;GUARDA EL NUMERO DE CARACTER
 MOV  DX,OFFSET vec
 MOV  DX,OFFSET imp
 MOV  AH,40H
 INT  21H
 imprime msjescr
 
 MOV  AH,3EH
 INT  21H
 JMP  menu
 
eliminar:
 MOV  AH,41H
 MOV  DX,OFFSET nombre
 INT  21H
 JC   salir
 imprime msjelim
 
salir:
 MOV  AH,04CH
 INT  21H
END
