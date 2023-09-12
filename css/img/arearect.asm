.model small
.stack 100
.data
dos equ 2 ; declaracion de constante=2
m3 db "Area: $"
m5 db "Area de un rectangulo",10,13,'$'
base db 4
altura db 7
unidades db 0
decenas db 0
.code
.startup
call cls

; imprime titulo
mov ah,09h
lea dx,m5
int 21h

;calcula area
mov al,base
mul altura ; multiplica: al * altura y el resultado queda en al
aam
mov decenas,ah
mov unidades,al

; imprime el area es
mov ah,09h
lea dx,m3
int 21h

call imprime2digitos
.exit

cls proc near
mov ah,00h
mov al,03h
int 10h
ret
endp

impcar proc near
add dl,30h
mov ah,02h
int 21h
ret
endp

imprime2digitos proc near
; imprime decenas
mov dl,decenas
call impcar
; imprime unidades
mov dl,unidades
call impcar
ret
endp
end
