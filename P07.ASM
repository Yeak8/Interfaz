TITLE Practica6

COMMENT *practica CALL*
	 
PUBLIC TEXTO1
PUBLIC TEXTO2
PUBLIC TEXTO3
PUBLIC TEXTO4
PUBLIC TEXTO5
PUBLIC TEXTO6
PUBLIC TEXTO7
PUBLIC NUMEROS
PUBLIC numDatos
PUBLIC numeroDatos
EXTRN INGRESONUMEROS:FAR
EXTRN ORDENAR_DESC:FAR
EXTRN ORDENAR_ASC:FAR
EXTRN IMPRIMIR:FAR
EXTRN ESPACIO:FAR
EXTRN REPETIR:FAR
EXTRN TITULOINICIAL:FAR
EXTRN TIPOORDENAMIENTO:FAR
EXTRN NUMERODEELEMENTOS:FAR
EXTRN INICIALIZAR:FAR

stack   segment para stack 'STACK'        
         db 128 dup ("PILA")        
     stack   ends

data segment para public 'data' 
	TEXTO1 db 0AH,0DH,"Practica 7, uso de librerías","$"
	TEXTO2 db 0AH,0DH,"Inserte numero (2 digitos): ","$"
	TEXTO3 db 0AH,0DH,"Ingrese 1 para ordenar descendentemente o 0 para ascendente","$"
	TEXTO4 db 0AH,0DH,"Si desea ordenar nuevamente presione 1, de lo contrario cualquier tecla.",0AH,0DH,"$"
	TEXTO5 db "  ",0AH,0DH,"$"
	TEXTO6 db 0AH,0DH,"Ingrese cantidad de numeros a ordenar(max 100, en formato de 3 digitos): ","$"
	TEXTO7 db " ","$"
	NUMEROS dw 0h,0h,0h,0h,0h,0h,0h,0h,0h,0h
			dw 0h,0h,0h,0h,0h,0h,0h,0h,0h,0h
			dw 0h,0h,0h,0h,0h,0h,0h,0h,0h,0h
			dw 0h,0h,0h,0h,0h,0h,0h,0h,0h,0h
			dw 0h,0h,0h,0h,0h,0h,0h,0h,0h,0h
			dw 0h,0h,0h,0h,0h,0h,0h,0h,0h,0h
			dw 0h,0h,0h,0h,0h,0h,0h,0h,0h,0h
			dw 0h,0h,0h,0h,0h,0h,0h,0h,0h,0h
			dw 0h,0h,0h,0h,0h,0h,0h,0h,0h,0h
			dw 0h,0h,0h,0h,0h,0h,0h,0h,0h,0h, "$"
	numDatos db 0,0,0
	numeroDatos dw 0
			
			
data ends

code segment para public 'code'
assume cs:code,ss:stack,ds:data
	 
prueba proc far
	PUSH DS
	SUB AX,AX
	PUSH AX	   
	MOV AX,SEG DATA
	MOV DS,AX
	
	
	INICIO_PROGRAMA:
	CALL INICIALIZAR
	CALL TITULOINICIAL
	CALL NUMERODEELEMENTOS
	CALL INGRESONUMEROS
	CALL TIPOORDENAMIENTO
	
	CMP AL,48
	JE ASC
	CMP AL,49
	JE DESC
	
	DESC:
	CALL ORDENAR_DESC
	JMP CONTINUA
	
	SALTO_INTERMEDIO:
	JMP INICIO_PROGRAMA
	
	ASC:
	CALL ORDENAR_ASC
	
	CONTINUA:
	CALL ESPACIO
	CALL IMPRIMIR
	
	CALL REPETIR
	CMP AL, 49
	JE SALTO_INTERMEDIO
	;JMP SALTO_INTERMEDIO
	RET
	
code ends
prueba ENDP
END