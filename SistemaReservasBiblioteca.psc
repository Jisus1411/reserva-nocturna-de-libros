Proceso SistemaReservasBiblioteca
	
	// 1. Definimos el arreglo de libros (en PSeInt los arreglos suelen iniciar en 1 por defecto)
	Dimension biblioteca[3]
	biblioteca[1] <- "game_of_thrones"
	biblioteca[2] <- "harry_potter"
	biblioteca[3] <- "the_hunger_games"
	
	Definir continuar Como Caracter
	continuar <- "s"
	
	// --- CICLO REPETITIVO PRINCIPAL ---
	Mientras continuar = "s" Hacer
		
		Escribir "=== SISTEMA DE RESERVAS NOCTURNAS DE BIBLIOTECA ==="
		Escribir "Libros disponibles:"
		
		// Mostramos la lista de libros numerada del 1 al 3
		Para i <- 1 Hasta 3 Con Paso 1 Hacer
			Escribir i, ". ", biblioteca[i]
		FinPara
		
		Escribir "--------------------------------------------------"
		
		// Solicitamos la opción del libro al usuario
		Escribir "Ingrese el número del libro que desea gestionar: "
		Leer opcion_usuario
		
		// Validamos que el número del libro sea válido
		Si opcion_usuario >= 1 Y opcion_usuario <= 3 Entonces
			
			libro_seleccionado <- biblioteca[opcion_usuario]
			Escribir "?? Libro seleccionado: --> ", Mayusculas(libro_seleccionado), " <--"
			Escribir ""
			Escribir "?? Información: El préstamo se registra de manera estándar a las 6:00 PM."
			
			// Solicitamos los datos de devolución
			Escribir "--- DATOS DE DEVOLUCIÓN ---"
			Escribir "Ingrese la hora de devolución (formato 24h, ej: 21 para las 9 PM, o 6 para el día siguiente): "
			Leer hora_devolucion
			
			Escribir "Ingrese los minutos de devolución (ej: 0): "
			Leer minutos_devolucion
			
			// --- LÓGICA DE CÁLCULO Y MULTAS ---
			HORA_INICIO_PRESTAMO <- 18 * 60  // 6:00 PM en minutos (1080)
			HORA_CIERRE <- 20 * 60           // 8:00 PM en minutos (1200)
			VALOR_MULTA_POR_HORA <- 5        // 5 pesos por hora
			
			HORA_FINAL <- (hora_devolucion * 60) + minutos_devolucion
			
			// Ajuste automático si se devuelve al día siguiente
			Si HORA_FINAL < HORA_INICIO_PRESTAMO Entonces
				HORA_FINAL <- HORA_FINAL + (24 * 60)
			FinSi
			
			Escribir ""
			Escribir "=================================================="
			Escribir "Libro gestionado: ", libro_seleccionado
			
			// Evaluamos si hay retraso después de las 8:00 PM
			Si HORA_FINAL > HORA_CIERRE Entonces
				minutos_retraso <- HORA_FINAL - HORA_CIERRE
				horas_retraso <- minutos_retraso / 60
				multa_total <- trunc(horas_retraso * VALOR_MULTA_POR_HORA)
				
				Escribir "?? Retraso registrado | Multa aplicada: $", multa_total, " pesos."
			SiNo
				Escribir "? Devolución exitosa dentro del tiempo reglamentario (Sin multas)."
			FinSi
			
			Escribir "=================================================="
			
		SiNo
			Escribir "? Error: El número de libro seleccionado no es válido."
		FinSi
		
		// Preguntamos si desea realizar otra gestión
		Escribir ""
		Escribir "¿Desea ingresar otra devolución? (s/n): "
		Leer continuar
		
		// Pasamos la respuesta a minúsculas para asegurar la validación
		continuar <- Minusculas(continuar)
		Escribir ""
		
	FinMientras
	
	Escribir "¡Gracias por usar el sistema de reservas nocturnas! Hasta luego."
	
FinProceso