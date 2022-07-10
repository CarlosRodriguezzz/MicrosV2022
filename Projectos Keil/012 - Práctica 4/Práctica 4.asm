/*	
	727576 - 		   Guzm�n Claustro Edgar
	727272 - Cordero Hern�ndez Marco Ricardo
	727366 - Rodr�guez Castro Carlos Eduardo
	
	--------------------------- PR�CTICA 4 ---------------------------
	
	Requerimientos:
	- Desplegar en display los caracteres presionados en un teclado
	  matricial (rebotes filtrados mediante MM74C922).
	- Al llegar al final de la primera l�nea, continuar en la inferior.
	- Al llenar todas las posiciones, borrar todo y regresar a la
	  primera posici�n de la primera l�nea.
	- Input de teclado detectado por interrupciones.
	- Funci�n ALT para interpretar dos inputs de teclado como ASCII. 
	  Solo al ingresar dos caracteres y al soltar ALT se mostrar�.
	- Funci�n SEND para enviar la informaci�n desplegada en pantalla
	  mediante bluetooth a trav�s de comunicaci�n serial. Tambi�n debe
	  ser detectado por interrupci�n. Considerar debouncing.
	
	------------------------------------------------------------------
*/
			
			RS 	 EQU P1.4				; Resister Select de LCD
			E  	 EQU P1.5				; Enable de LCD
			LCD  EQU P2					; Bus para LCD
			KEYS EQU P1					; Tecla codificada
				
			CCNT EQU R2					; Contador de caracteres para display (max. 32 | 20H)

; --------- SECUENCIA DE INICIO DE DISPLAY EN RST ----------
			ORG 0000H
								
			JMP LCD_INIT
			
; ----------------------------------------------------------



; ------------------ INTERRUPCI�N TECLADO ------------------

			ORG 0003H
			
KEY_IN:		MOV A, KEYS
			ANL A, #0FH
			MOVC A, @A + DPTR
			ACALL LCD_CHR
			RETI

; ----------------------------------------------------------



; ----------------- INTERRUPCI�N BLUETOOTH -----------------

			ORG 0013H
				
SEND_ND:	SJMP $

; ----------------------------------------------------------



; -------------------- FLUJO PRINCIPAL ---------------------

			ORG 0040H

/* --------------------- SUBRUTINAS --------------------- */
; Subrutina de atraso para dejar libres temporizadores
DELAY: 		MOV R7, #30H
D_0: 		MOV R6, #0FFH
D_1: 		DJNZ R6, D_1
			DJNZ R7, D_0
			RET

LCD_CLR:	MOV A, #1H					; 20H a cada posici�n | Limpiar pantalla
			ACALL LCD_CMD
			
LCD_FL:		MOV A, #80H					; Cursor en primera l�nea, primera posici�n
			ACALL LCD_CMD

; Subrutina para enviar comandos a LCD
LCD_CMD: 	MOV LCD, A					; Posicionar comando
			CLR RS 						; Modo comando
			SETB E
			ACALL DELAY
			CLR E 						; Enviar comando
			ACALL DELAY
			RET

; Subrutina para enviar datos/caracteres a LCD
LCD_CHR: 	PUSH 0E0H					; Guardar dato a desplegar

LCD_ESL:	CJNE CCNT, #20H, LCD_EFL	; Fin de segunda l�nea
			ACALL LCD_CLR				; Limpiar pantalla
			ACALL LCD_FL				; y resetear a primera posici�n
			MOV CCNT, #0				; Resetear conteo de caracteres
			
LCD_EFL:	CJNE CCNT, #10H, LCD_SND	; Fin de primera l�nea
			MOV A, #0C0H				; Cursor en segunda l�nea, primera posici�n
			ACALL LCD_CMD
			
LCD_SND:	POP 0E0H					; Recuperar dato a desplegar
			MOV LCD, A 					; Posicionar datos
			SETB RS 					; Modo datos
			SETB E
			ACALL DELAY
			CLR E						; Enviar datos
			ACALL DELAY
			INC CCNT
			RET

/* ------------------------------------------------------ */

; Usar RAM general de 0x30 a 0x4F para tranmisi�n serial

LCD_INIT:	ACALL DELAY
			ACALL DELAY
			
			MOV B, #4H
			MOV A, #38H			; Modo de 8 bits, 2 l�neas (4 veces)
LI_0:		ACALL LCD_CMD
			ACALL DELAY
			DJNZ B, LI_0
			
			MOV A, #0FH 		; Display, cursor y parpadeo encendidos
			ACALL LCD_CMD
			
			; Se incluye el siguiente comando por aseguramiento pero es omisible
			; Incrementar posici�n, desplazamiento desactivado
			MOV A, #6H
			ACALL LCD_CMD
			
			ACALL LCD_CLR		; Limpiar LCD
			ACALL LCD_FL		; Cursor inicial

MAIN:		MOV DPTR, #0A8H * 0AH		; Posicionar apuntador en tabla de valores
			MOV IE, #95H
			SJMP $
				
; ----------------------------------------------------------



; ------------- TABLAS PARA DECODIFICAR TECLAS -------------

			ORG 0690H
			
			DB 	'1', '2', '3', 'A'
			DB	'4', '5', '6', 'B'
			DB	'7', '8', '9', 'C'
			DB	'E', '0', 'F', 'D'

; ----------------------------------------------------------

			END