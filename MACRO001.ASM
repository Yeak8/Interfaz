TITLE Practica6

stack   segment para stack 'STACK'        
        db 64 dup ("STACK   ")        
stack   ends

data segment para public 'data' 

    texto1 db 0AH,0DH,"Practica 6 utilizando MACRO","$"
	texto2 db 0AH,0DH,"Inserte el numero de dos digitos elegido,"
		   db 0AH,0DH,"ejemplo: (Si quiere el numero 5, inserte 05). :","$"
	texto3 db 0AH,0DH,"Ingrese 1 para ordenar descendentemente o 0 para ascendente","$"
	texto4 db 0AH,0DH,"Si desea ordenar nuevamente presione 1, de lo contrario presione cualquier tecla.",0AH,0DH,"$"
	texto5 db 0AH,0DH,"$"
	numeros dw 0h,0h,0h,0h,0h,0h,0h,0h,0h,0h,"$"
data ends

COMMENT *practica MACRO*
;____________MACRO____________________

ESPACIO MACRO
     MOV AH,09H
	 MOV DX,OFFSET texto5
	 INT 21h
ENDM

;________________________________
INGRESAR_DATOS MACRO

     MOV SI,0
	 CICLO_INGRESONUMEROS:
	 MOV AH,09H
	 MOV DX,OFFSET texto2
	 INT 21H
	 
	 MOV AH,01H
	 INT 21H
	 MOV BH,AL
	 
	 MOV AH,01H
	 INT 21H
	 MOV BL,AL
	 MOV numeros[SI],BX
	 
	 INC SI
	 INC SI
	 CMP SI,20
	 JL CICLO_INGRESONUMEROS
	 
	 MOV SI,0
	 MOV DI,0
	 ENDM
	 
	 ;_________________________________
	 ASCENDENTE MACRO
	 
	 MOV AX,numeros[SI]
	 MOV BX,numeros[DI]
	 
	 CMP AX,BX
	 JL SWAPMENOR
	 INC DI
	 INC DI
	 CMP DI,20
	 JL ASC
	 MOV DI,0
	 INC SI
	 INC SI
	 CMP SI,20
	 JL ASC
	 ENDM
	 ;________________________________
	 
	 DESCENDENTE MACRO
	 
	 MOV AX,numeros[SI]
	 MOV BX,numeros[DI]
	 
	 CMP AX,BX
	 JG SWAPMAYOR
	 INC DI
	 INC DI
	 CMP DI,20
	 JL DESC
	 
	 MOV DI,0
	 INC SI
	 INC SI
	 CMP SI,20
	 JL DESC
	 ENDM
	 
	 ;________________________________
	 
	 REPETIR MACRO
	 MOV AH,09H
	 MOV DX,OFFSET texto4
	 INT 21H
	 
	 MOV AH,01H
	 INT 21h
	 CMP AL,49
	 JE SALTO_INTERMEDIO
	 ENDM
	 ;________________________________
	 code segment para public 'code'
	 assume cs:code,ss:stack,ds:data
	 
	 prueba proc far  
       PUSH DS
       SUB AX,AX
       PUSH AX	   
       MOV AX,SEG DATA;Estas dos instrucciones siempre las van a poner
       MOV DS,AX
	   
	   ;paso1:desplegar mensaje inicial
	   INICIO_PROGRAMA:
	   MOV AH,09H
	   MOV DX,OFFSET texto1
	   INT 21H
	   
	   ;paso2:se solicitan los 10 numeros
	   INGRESAR_DATOS
	   
	   orden:
	   ;paso3:seleccionar tipo de ordenamiento
	   MOV AH,09H
	   MOV DX,OFFSET texto3
       INT 21H
	   
	   MOV AH,01H
	   INT 21H
	   CMP AL,48
	   JE ASC
	   CMP AL,49
	   JE DESC
	   JMP orden
	   ;paso4:ordenar de manera ascendente y descendente.
	   
	   DESC:
	   DESCENDENTE
	   
	   JMP CONTINUA
	   
	   SWAPMAYOR:
	   MOV numeros[DI],AX
	   MOV numeros[SI],BX
	   JMP DESC
	   
	   ;________________________________
	   SALTO_INTERMEDIO:
	   JMP INICIO_PROGRAMA
	   ;________________________________
	   
	   ASC:
	   ASCENDENTE
	   JMP CONTINUA
	   
	   SWAPMENOR:
	   MOV numeros[DI],AX
	   MOV numeros[SI],BX
	   JMP ASC
	   
	   ;paso5:impresion de los resultados
	   CONTINUA:
	   ESPACIO
	   MOV SI,0
	   
	   CICLO_IMPRESION:
	   MOV BX,numeros[SI]
	   MOV DL,BH
	   MOV AH,06H
	   INT 21H
	   
	   MOV DL,BL
	   MOV AH,06H
	   INT 21H
	   
	   ESPACIO
	   INC SI
	   INC SI
	   CMP SI,20
	   JL CICLO_IMPRESION
	   
	   ;pregunta si se desea repetir
	   REPETIR
	   
	   RET
	   
     prueba endp

     code ends

     END prueba