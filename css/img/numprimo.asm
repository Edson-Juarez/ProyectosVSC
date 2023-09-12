.model small
.stack 100h
.data
        numero db 30h,30h,30h
        factor db 10
        primo db 'Es primo',10,13,'$'
        noprimo db 'No es primo',10,13,'$'
.code

convertir proc
sub al, 30h
ret
convertir endp

Inicio:
mov ax, @data
mov ds, ax
   mov ah,1
        int 21h
        call convertir
        mov numero,al
        int 21h
        call convertir
        mov numero[1],al
        int 21h
        call convertir
        mov numero[2],al


        mov bh,numero[0]
   mov bl,numero[1]
        mov cl,4
   shl bl,cl
   shr bx,cl

   xor dl,dl
   mov dl,2
bucle:   
   cmp dl,bl
   jz esprimo
   xor ax,ax
   mov al,bl
   mov cl,dl
   div cl
   cmp ah,0
   jz noesprimo
   inc dl
   jmp bucle
   

noesprimo:
   mov ah, 9
   lea dx, noprimo
   int 21h
   jmp fin
esprimo:
   mov ah, 9
   lea dx, primo
   int 21h
   
   
fin:
   mov ah, 4Ch
   int 21h
   end inicio