PAGE 40,132

TITLE Primer Programa en Ensamblador

COMMENT * Este programa pretende mostrar en conjunto del debuguer
          los diferentes registros del sistemas y unas operaciones
          basicas que permitan tener un primer acercamiento al en-
          samblador y al MASM51*

;se inicializara el stack a continuacion


;PUBLIC PROCEDIMIENTO

stack   segment para stack 'STACK'        
        db 64 dup ("STACK   ")        
stack   ends

data segment para memory 'data'      
    MASA     DB  50, 60, 70, 80, 90   ; Arreglo de masa
	MASAT    DW ?
	DISTANCIA DB  10, 20, 30, 40, 50  ; Arreglo de distancia
	DISTANCIAT DW ?
	TIEMPO   DB  2, 3, 4, 5, 6        ; Arreglo de tiempo
	TIEMPOT  DW ?
	VEL      DW  ?                    ; Variable para almacenar la velocidad promedio
	FUERZA   DW  ?                    ; Variable para almacenar la fuerza promedio
	TRABAJO  DW  ?                    ; Variable para almacenar el trabajo promedio
	CONST_G  DW 10    
data ends

code segment para 'code'
	assume cs:code,ss:stack,ds:data

prueba proc far       
       MOV AX,SEG DATA;Estas dos instrucciones siempre las van a poner
       MOV DS,AX
	   ; suma distancia________________________________________________________________
	   MOV AX,0H
	   MOV BX,0H
	   MOV SI,0H
	   MOV AL,DISTANCIA[SI]
	   ADD BL,AL
	   ADC AH,[SI]
	   
	   MOV AL,DISTANCIA[SI+1]
	   ADD BL,AL
	   ADC AH,[SI+1]
	   
	   MOV AL,DISTANCIA[SI+2]
	   ADD BL,AL
	   ADC AH,[SI+2]
	   
	   MOV AL,DISTANCIA[SI+3]
	   ADD BL,AL
	   ADC AH,[SI+3]
	   
	   MOV AL,DISTANCIA[SI+4]
	   ADD BL,AL
	   ADC AH,[SI+4]
	   MOV DISTANCIAT,BX
	   ;suma tiempo_____________________________________________________________________________________
       MOV AX,0H
	   MOV BX,0H
	   MOV SI,0H
	   MOV AL,TIEMPO[SI]
	   ADD BL,AL
	   ADC AH,[SI]
	   
	   MOV AL,TIEMPO[SI+1]
	   ADD BL,AL
	   ADC AH,[SI+1]
	   
	   MOV AL,TIEMPO[SI+2]
	   ADD BL,AL
	   ADC AH,[SI+2]
	   
	   MOV AL,TIEMPO[SI+3]
	   ADD BL,AL
	   ADC AH,[SI+3]
	   
	   MOV AL,TIEMPO[SI+4]
	   ADD BL,AL
	   ADC AH,[SI+4]
	   MOV TIEMPOT,BX
	   
	   ;dividir velocidad promedio_________________________________________________________
	   MOV AX,0H
	   MOV BX,0H
	   MOV AX,DISTANCIAT
	   MOV BX,TIEMPOT
	   DIV BX
	   MOV VEL,AX
	   
	   ;suma_multiplicar fuerza promedio_________________________________________________________
	   MOV AX,0H
	   MOV BX,0H
	   MOV SI,0H
	   
	   MOV AL,MASA[SI]
	   ADD BL,AL
	   ADC AH,[SI]
	   
	   MOV AL,MASA[SI+1]
	   ADD BL,AL
	   ADC AH,[SI+1]
	   
	   MOV AL,MASA[SI+2]
	   ADD BL,AL
	   ADC AH,[SI+2]
	   
	   MOV AL,MASA[SI+3]
	   ADD BL,AL
	   ADC AH,[SI+3]
	   
	   MOV AL,MASA[SI+4]
	   ADD BL,AL
	   ADC AH,[SI+4]
	   MOV MASAT,BX
	   
	   MOV AX,0H
	   MOV BX,0H
	   MOV AX,MASAT
	   MOV BX,CONST_G
	   MUL BX
	   MOV FUERZA,AX
	   
	  ;MULTIPLICACION TRABAJO_____________________________________
	  
	   MOV AX,0H
	   MOV BX,0H
	   MOV AX,FUERZA
	   MOV BX,DISTANCIAT
	   MUL BX
	   MOV TRABAJO,AX
	   

prueba endp

code ends

END prueba
