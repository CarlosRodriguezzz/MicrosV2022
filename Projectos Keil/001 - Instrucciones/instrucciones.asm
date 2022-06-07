; Programa con ejemplo de instrucciones y modos de direccionamiento

			ORG		0000H			; El c�digo se colocar� a partir de la localidad 0
			SJMP 	START
			ORG		0040H

START:		INC		A				; Aritm�tica
			ADD		A, R5			; Aritm�tica
			ADD		A, #03			; Aritm�tica
			; NOP		
			MOV		A, P1			; Transferencia de informaci�n
			ANL		A, #0FH			; L�gica dato hexadecimal | direccionamiento inmediato
			MOV		A, #01010101B	; Transferencia dato binario
			JNZ		JMP_EX			; Bifurcaci�n de programa o control de flujo del programa
			SJMP	$

JMP_EX:		MOV		A, #00H
			JZ		START			; Bifurcaci�n de programa o control de flujo del programa
			
			
			END