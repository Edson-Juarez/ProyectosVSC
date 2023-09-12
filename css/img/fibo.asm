.model small
.stack
.data
    contador dw 2                       ;inicializa el contador
    arreglo db 13 dup (0)               ;creacion del arreglo
    n3 db 0
    
.code
    main proc far 
        mov ax,@data
        mov ds,ax

        mov ah,0
        mov al,1

        mov arreglo[0],ah
        mov arreglo[1],al

        mov si,0
        mov di,1

        mov cx,13d
        ciclo:                          ;Ciclo de suma y resta de Fibonacci
            mov al,arreglo[si]          ;mover a al lo del arreglo en si
            mov bl,arreglo[di]          ;mover a bl lo del arreglo en di
            add al,bl                   ;Sumamos al lo de bl
            mov bx,contador             ;
            mov arreglo[bx],al
            inc si                      ;incrementamos en uno las variables de si y di en que mpodifica el arreglo
            inc di
            inc contador                ;incrementa el contador
        loop ciclo

        mov si,0
        mov cx,13d

        ciclo_imprime:
            mov ax,0                    ;inicializamos el acumulador    
            mov al,arreglo[si]          ;valor de si a acumulador AL
            cmp ax,144d                 ;5917 compara a ax
            jge ajusta_3_digitos        ;salto condicional

            ajustar_2_digitos:          ;Ajuste de dos digitos
            aam
            mov bx,ax
            add bx,3030h

            mov ah,02h
            mov dl,bh
            int 21h

            mov ah,02h
            mov dl,bl
            int 21h

            mov ah,02h
            mov dl,' '
            int 21h
            jmp avanza

            ajusta_3_digitos:     ;Ajuste de dos digitos
                aam               ;ajuste de multiplicación
                add al,30h 
                mov n3,al

                mov al,ah
                mov ah,0
                aam
                mov bx,ax
                add bx,3030h

                mov ah,02h
                mov dl,bh
                int 21h

                mov ah,02h
                mov dl,bl
                int 21h

                mov ah,02h
                mov dl,n3
                int 21h

                mov al,02h
                mov dl,' '
                int 21h

        avanza:                             ;incrementa en uno si para avanzar a ala siguiente posición
            inc si
    loop ciclo_imprime                      ;loop del ciclo imprime

        mov ah,4ch                          
        int 21h

    main endp
    end main