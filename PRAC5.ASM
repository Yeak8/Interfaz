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
	DATOS	DB 35, 95, 35, 91, 35, 72, 11, 88, 18, 55
			DB 82, 31, 18, 31, 65, 82, 55, 7, 18, 63
			DB 24, 32, 92, 20, 19, 79, 3, 11, 19, 49
			DB 23, 44, 19, 42, 42, 35, 48, 19, 22, 81
			DB 19, 21, 15, 42, 20, 13, 11, 24, 23, 55
			DB 18, 18, 17, 16, 62, 34, 13, 60, 21, 72
			DB 77, 43, 26, 52, 90, 73, 6, 20, 18, 49
			DB 21, 20, 60, 50, 43, 51, 34, 95, 54, 19
			DB 93, 16, 15, 10, 20, 21, 20, 20, 58, 48
			DB 12, 34, 93, 20, 19, 54, 19, 39, 27, 50
	minimo DB 0
	maximo DB 0	

data ends

code segment para 'code'
	assume cs:code,ss:stack,ds:data

prueba proc far       
		MOV AX,SEG DATA;Estas dos instrucciones siempre las van a poner
		MOV DS,AX
		MOV SI, 0H

		;Cargamos el primer numero del arreglo tanto al minimo como al maximo
		MOV AX, 0H
		MOV BX, 0H
		MOV AL, DATOS[SI]
		MOV minimo, AL
		MOV BL, DATOS[SI]
		MOV maximo, BL
		
		
		MOV CX, 100
		otro_loop:
			; Comparamos el número actual con el máximo
			mov al, DATOS[SI]
			cmp al, maximo
			JB es_menor
			mov maximo, al
			JMP no_es_menor
			es_menor:
				; Comparamos el número actual con el mínimo
				cmp minimo, al
				jbe no_es_menor
				mov minimo, al


			no_es_menor:
				; Avanzamos al siguiente número del arreglo
				inc SI
				dec CX
				LOOP otro_loop
		
		
		MOV AL, minimo
		MOV BL, maximo
			
		;Fin del programa del programa

	   

prueba endp

code ends

END prueba