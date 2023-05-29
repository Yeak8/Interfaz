PAGE 40,132

TITLE Practica2 Evidencias

;Generar 2 arreglos denominados Arreglo1 y Arreglo2 de tipo byte con 5 datos.
;Sumar cada dato del primer arreglo con su correspondiente en el segundo arreglo.
;Poner cada resultado en un arreglo tipo word llamado resultados.

;se inicializara el stack a continuacion
;PUBLIC PROCEDIMIENTO

stack   segment para stack 'STACK'        
        db 64 dup ("STACK   ")        
stack   ends

data segment para memory 'data' 
		Arreglo1 db 1H, 2H, 3H, 4H, 5H
		Arreglo2 db 10H, 20H, 30H, 40H, 50H
		Resultados dw 0H, 0H, 0H, 0H, 0H
data ends

code segment para 'code'
	assume cs:code,ss:stack,ds:data

prueba proc far       
       MOV AX,SEG DATA	;Estas dos instrucciones siempre las van a poner
       MOV DS,AX
       
		mov si,0;
		mov AX,0;
		mov al, Arreglo1[si]
		add al, Arreglo2[si]
		adc AX,0;
		mov Resultados[si], ax
		
		mov AX,0;
		mov al, Arreglo1[si+1]
		add al, Arreglo2[si+1]
		adc AX,0;
		mov Resultados[si+2], ax
		
		mov AX,0;
		mov al, Arreglo1[si+2]
		add al, Arreglo2[si+2]
		adc AX,0;
		mov Resultados[si+4], ax
		
		mov AX,0;
		mov al, Arreglo1[si+3]
		add al, Arreglo2[si+3]
		adc AX,0;
		mov Resultados[si+6], ax
		
		mov AX,0;
		mov al, Arreglo1[si+4]
		add al, Arreglo2[si+4]
		adc AX,0;
		mov Resultados[si+8], ax
		mov AX,0;
prueba endp

code ends

END prueba