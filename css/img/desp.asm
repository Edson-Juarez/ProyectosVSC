.model small

.data

.code

main proc  
MOV AL, 10110111B ; AL = 10110111
SHR AL, 01 ; AL = 01011011 Un corrimiento a la derecha
SHR AL, CL ; AL = 00001011 Tres corrimientos adicionales a la derecha

MOV CL, 03
MOV AL, 10110111B ; AL = 10110111
SHL AL, 01 ; AL = 01101110 Un corrimiento a la izquierda
SHL AL, CL ; AL = 01110000 Tres corrimientos mas a la izq

MOV CL, 03
MOV BL, 10110111B ; BL = 10110111
SHR BL, 01 ; BL = 11011011 Una rotación a la der
SHR BL, CL ; BL = 00001011 Tres rotaciones a la der

MOV CL, 03
MOV BH, 10110111B ; BH = 10110111
ROR BH, 01 ; BH = 11011011 Una rotación a la derecha
ROR BH, CL ; BH = 00001011 Tres rotaciones a la derecha
endp

end main