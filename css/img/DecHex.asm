.MODEL SMALL
.STACK 100H
.DATA 
 PROMPT_TRY_MSG DB 'INTENTA DE NUEVO.$'
 PRMPT_MSG_1 DB 'DIGITE UN NUMERO HEX:$'
 OUTPUT_PRMPT DB 0AH, 0DH, 'SALIDA: $'
 ASK_PROMPT DB 0AH ,0DH, 'DE NUEVO?$'
.CODE
Main proc                       
    mov ax,@data
    mov ds,ax
    TOP:
    MOV AH, 9
    LEA DX, PRMPT_MSG_1
    INT 21H

    MOV AH, 1
    INT 21h
    MOV BL, AL

    CMP BL, 30h
    JL TRY_MSG

    CMP BL, 46H
    JG TRY_MSG 
    
    CMP BL, 39H
    JLE DIGIT 

    MOV AH, 9
    LEA DX, OUTPUT_PRMPT  ; imprime cadena antes de la conversión
    INT 21H 

    SUB BL, 11H

    MOV AH, 2
    MOV DL,31H
    INT 21H 
    MOV DL, BL
    INT 21h

    AGAIN:
    MOV AH, 9
    LEA DX, ASK_PROMPT     ;prgunta por volver a intentar
    INT 21H 

    MOV AH, 1
    INT 21H 
    MOV BH, AL
    MOV AH, 2
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H

    CMP BH, 'S'     ;se prepara para recibir desde teclado S o s para Si
    JE TOP 
    CMP BH, 's'
    JE TOP
    JMP END_

    DIGIT:
    MOV AH, 9
    LEA DX, OUTPUT_PRMPT
    INT 21H

    MOV AH, 2
    MOV DL, BL
    INT 21H

    JMP AGAIN

    TRY_MSG:
    MOV AH, 9
    LEA DX, PROMPT_TRY_MSG
    INT 21H
    JMP TOP

END_:
MOV AH, 4ch
INT 21h

Main endp
END Main