TITLE Llamen_a_diosito_pa_mi_comple

COMMENT * Ricardo Grajales Castillo *

; se inicializará el stack a continuación

stack   segment stack 'STACK'        
        db 64 dup ("STACK   ")        
stack   ends

section .data
    nombre db 'Ricardo Grajales Castillo', 0
    mensaje db 'INSERTA UNA fraselistalista DE HASTA 150 CARACTERES SIN SIGNOS DE PUNTUACION, SIN ACENTOS, SIN Ñ o ñ  Y SIN NUMEROS Y PRESIONA ENTER.: $'
    fraselistalista db 150 dup(0)
    opcion db 0

section .text
    org 100h
	
;SOLICITUD DE DATOS.

start:
    ;Nombre del alumno
    mov ah, 09h
    mov dx, nombre
    int 21h

    ; Solicita insertar una fraselistalista
    mov ah, 09h
    mov dx, mensaje
    int 21h

    ; Leer fraselistalista ingresada
    mov ah, 0Ah
    mov dx, fraselistalista
    int 21h

    ; Solicita una opción
    mov ah, 09h
    mov dx, opcion_menu
    int 21h

    ; Lee la opción elegida
    mov ah, 01h
    int 21h
    mov [opcion], al

    ; Realiza y modificar la fraselistalista
    cmp al, 'A'
    je convertm
    cmp al, 'B'
    je convertir_minusculas
    cmp al, 'C'
    je convertitulo

    ; Imprime
    mov ah, 09h
    mov dx, fraselistalista
    int 21h

    ; Pregunta al usuario si desea salir o repetir
    mov ah, 09h
    mov dx, mensaje_salida
    int 21h

    ; Lee la respuesta
    mov ah, 01h
    int 21h
    cmp al, 'S'
    jne start

    ; Salir
    mov ah, 4Ch
    int 21h

;CONVERTIDOR DE DATOS

convertm:
    ; Convierte mayúsculas
    mov si, fraselistalista
    converloopm:
        mov al, [si]
        cmp al, 0
        je convertir_fin
        cmp al, 'a'
        jb convertir_next
        cmp al, 'z'
        ja convertir_next
        sub al, 32
        mov [si], al
    convertir_next:
        inc si
        jmp converloopm
    convertir_fin:
    ret

convertir_minusculas:
    ; Convierte minúsculas
    mov si, fraselistalista
    converloop:
        mov al, [si]
        cmp al, 0
        je convertir_fin
        cmp al, 'A'
        jb convertir_next
        cmp al, 'Z'
        ja convertir_next
        add al, 32
        mov [si], al
    convertir_nextlisto:
        inc si
        jmp converloop
    convertir_final:
    ret

convertitulo:
    ; Convierte a tipo titulo
    mov si, fraselistalista
    mov al, [si]
    cmp al, 'a'
    jb convertir_next
    cmp al, 'z'
    ja convertir_next
    sub al, 32
    mov [si], al
    convertir_titulo:
        inc si
        Intconverloop:
            mov al, [si]
            cmp al, 0
            je convertir_fin
            cmp al, ' '
            jne convertir_nominuscula
            inc si
            mov al, [si]
            cmp al, 'a'
            jb convertir_next
            cmp al, 'z'
            ja convertir_next
            sub al, 32
            mov [si], al
            jmp convertir_next
            convertir_nominuscula:
                cmp al, 'A'
                jb convertir_next
                cmp al, 'Z'
                ja convertir_next
                add al, 32
                mov [si], al
            jmp convertir_next
        jmp converloop
    convertir_finalizado:
    ret
	
;PREGUNTAR SI QUIERE REPETIR O SALIR

opcion_menu db 'Indique Lo Siguiente: A) Todo Mayusculas, B) Todo Minusculas, C) Tipo de titulos.$'
mensaje_salida db '¿DESEAS SALIR O INSERTAR OTRO NOMBRE?. S=SALIR, cualquier otra tecla repite$', 0

times 510-($-$$) db 0
dw 0AA55h