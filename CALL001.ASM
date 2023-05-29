     TITLE Practica6

     COMMENT *practica CALL*

     stack   segment para stack 'STACK'        
         db 64 dup ("STACK   ")        
     stack   ends

     data segment para public 'data' 

         texto1 db 0AH,0DH,"Practica 6 utilizando CALL","$"
		texto2 db 0AH,0DH,"Inserte el numero de dos digitos elegido,"
			   db 0AH,0DH,"ejemplo: (Si quiere el numero 5, inserte 05). :","$"
		texto3 db 0AH,0DH,"Ingrese 1 para ordenar descendentemente o 0 para ascendente","$"
		texto4 db 0AH,0DH,"Si desea ordenar nuevamente presione 1, de lo contrario presione cualquier tecla.",0AH,0DH,"$"
		texto5 db 0AH,0DH,"$"
		numeros dw 0h,0h,0h,0h,0h,0h,0h,0h,0h,0h,"$"
     data ends

	 code segment para public 'code'
	 assume cs:code,ss:stack,ds:data
	 
	 prueba proc far  
         PUSH DS
         SUB AX,AX
         PUSH AX	   
         MOV AX,SEG DATA;Estas dos instrucciones siempre las van a poner
         MOV DS,AX
		 

		 INICIO_PROGRAMA:     
		 
		 MOV AH,09H      ;para imprimir en pantalla los nombres
		 LEA DX,texto1     ;sirve para leer lo que esta en la variable que se va imprimir
		 INT 21H          ;para ejecutar la funcion
		 
		 CALL INGRESONUMEROS   ;utilizamos call llamando al ingresar numeros
		 
		 orden:              ;utilizamos saltos
		 MOV AH,09H          
		 LEA DX,texto3
		 INT 21H
		 
		 MOV AH,01H
		 INT 21H
		 CMP AL,48
		 JE ASC
		 CMP AL,49
		 JE DESC
		 JMP orden
		 
		 DESC:
		 CALL ORDENAR_DESC     ;call ordenar descendentemente
		 JL DESC
		 MOV DI,0
		 INC SI
		 INC SI
		 CMP SI,20
		 JL DESC
		 
		 JMP CONTINUA
		 
		 SALTOMAYOR:
		 MOV numeros[DI],AX
		 MOV numeros[SI],BX
		 JMP DESC
		 
		 SALTO_INTERMEDIO:
		 JMP INICIO_PROGRAMA
		 
		 ASC:
		 CALL ORDENAR_ASC    ;call orden ascendente
		 JL ASC
		 
		 MOV DI,0
		 INC SI
		 INC SI
		 CMP SI,20
		 JL ASC
		 
		 JMP CONTINUA
		 
		 SALTOMENOR:
		 MOV numeros[DI],AX
		 MOV numeros[SI],BX
		 JMP ASC
		 
		 CONTINUA:
		 MOV AH,09H
		 LEA DX,texto5
		 INT 21H
		 MOV SI,0
		 
		 CICLO_IMPRESION:
		 CALL IMPRIMIR          ;por ultimo call imprimir
		 JL CICLO_IMPRESION
		 
		 MOV AH,09H
		 LEA DX,texto4
		 INT 21H
		 
		 MOV AX,0
		 MOV AH,01H
		 INT 21H
		 CMP AL,49
		 JE SALTO_INTERMEDIO
		 jmp salir
		
		 salir:
			RET
		
     prueba endp
	 
		 
		 SALTOMAYOR1:
			jmp SALTOMAYOR
		 
		 INGRESONUMEROS PROC NEAR
		     MOV SI,0
		     CICLO_INGRESONUMEROS:
			 MOV AH,09H
			 LEA DX,texto2
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
			 
			 RET
		 INGRESONUMEROS ENDP
		 
		 ORDENAR_DESC PROC NEAR
		     
			 MOV AX,numeros[SI]
			 MOV BX,numeros[DI]
			 
			 CMP AX,BX
			 JG SALTOMAYOR1
			 INC DI
			 INC DI
			 CMP DI,20
			 
			 RET
		 ORDENAR_DESC ENDP

		 ORDENAR_ASC PROC NEAR
		    
			 MOV AX,numeros[SI]
			 MOV BX,numeros[DI]
			 
			 CMP AX,BX
			 JL SALTOMENOR
			 INC DI
			 INC DI
			 CMP DI,20
			 RET
		 ORDENAR_ASC ENDP

		 IMPRIMIR PROC NEAR
		     MOV BX,numeros[SI]
			 MOV DL,BH
			 MOV AH,06H
			 INT 21H
			 
			 MOV DL,BL
			 MOV AH,06H
			 INT 21H
			 
			 MOV AH,09H
			 LEA DX,texto5
			 INT 21H
			 
			 INC SI
			 INC SI
			 CMP SI,20
			 RET
		 IMPRIMIR ENDP
		 
		 

     code ends

     END prueba