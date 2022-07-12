/*	
	Ejercicio pr�ctico   
	Puede emplear computadora, libro, apuntes, reportes de sus pr�cticas, etc.

	Se debe incluir para la entrega: enunciado (favor de tomar fotograf�a con su tel�fono m�vil), diagrama esquem�tico detallado de hardware,
	mapas de memoria, diagrama de flujo de los programas, software en ensamblador con COMENTARIOS RELEVANTES y el archivo.hex.
	Es requisito emplear al menos una interrupci�n distinta al RESET.

	Enunciado:
	La uni�n de ca�eros CNC  desea contar con un sistema para monitorear la humedad del suelo de sus parcelas.
	Para ello cuenta con un sensor de humedad conectado a un convertidor anal�gico-digital de 8 bits y salida serial compatible con el est�ndar RS232
	a 9,600 baudios. El microcontrolador tomar� esa informaci�n, la convertir� en ASCII y la enviar� a un m�dulo de transmisi�n por radiofrecuencia el
	cual recibe  tambi�n palabras seriales a la velocidad antes mencionada.

	El monitor contar� adem�s con una pantalla de cristal l�quido en la cual mostrar� el dato. Si el nivel de humedad es mayor a 150, el monitor
	encender� un led rojo y en la segunda l�nea aparecer� la palabra MOJADO (es decir no se puede cosechar), la cual desaparecer� cuando el nivel
	baje de dicho valor. As� mismo, pasada la contingencia el led deber� apagarse. Otro tanto ocurrir� si la humedad es menor a 50, en cuyo caso
	aparecer� la palabra SECO.

	Indique los componentes de hardware que emplear�. La computadora y le convertidor ser�n vistos como cajas negra que cumple con los est�ndares de
	comunicaci�n antes mencionados.
*/