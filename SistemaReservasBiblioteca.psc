ALGORITMO ReservaNocturnaLibros

    DEFINIR biblioteca COMO LISTA DE CADENAS
    biblioteca <- ["game_of_thrones", "harry_potter", "lord_of_the_rings", "kill_bill", "metamorphosis", "anatomy_of_moore", "the_hunger_games"]

    // --- FUNCIÓN PARA CALCULAR MULTAS ---
    FUNCION calcular_multa_reserva(hora_dev, min_dev) RETORNA CADENA
        HORA_INICIO_PRESTAMO <- 18 * 60   // 1080 minutos (6:00 PM)
        HORA_CIERRE <- 20 * 60            // 1200 minutos (8:00 PM)
        VALOR_MULTA_POR_HORA <- 150       // 150 pesos por hora

        hora_final_min <- (hora_dev * 60) + min_dev

        // Ajuste automático si se devuelve al día siguiente
        SI hora_final_min < HORA_INICIO_PRESTAMO ENTONCES
            hora_final_min <- hora_final_min + (24 * 60)  // Sumar 1440 min
        FIN_SI

        // Si se devuelve después de las 8:00 PM (20:00)
        SI hora_final_min > HORA_CIERRE ENTONCES
            minutos_retraso <- hora_final_min - HORA_CIERRE
            horas_retraso <- minutos_retraso / 60
            multa_total <- ENTERO(horas_retraso * VALOR_MULTA_POR_HORA)
            
            RETORNAR "⚠️ Retraso registrado: " + FORMATO(horas_retraso, "0.0") + " hora(s) | Multa aplicada: $" + multa_total + " pesos."
        FIN_SI

        // Si se devuelve a tiempo
        RETORNAR "✅ Devolución exitosa dentro del tiempo reglamentario (Sin multas)."
    FIN_FUNCION


    // --- INTERACCIÓN CON EL USUARIO (CICLO PRINCIPAL) ---
    MOSTRAR "=== SISTEMA DE RESERVAS NOCTURNAS DE BIBLIOTECA ==="

    MIENTRAS VERDADERO HACER
        MOSTRAR "\nLibros disponibles:"
        
        // Recorremos la lista mostrando el índice + 1 y el nombre del libro
        PARA i DESDE 0 HASTA LONGITUD(biblioteca) - 1 HACER
            MOSTRAR (i + 1) + ". " + biblioteca[i]
        FIN_PARA
        
        MOSTRAR "--------------------------------------------------"
        
        // Selección de usuario
        LEER opcion_usuario
        indice_libro <- opcion_usuario - 1

        // Validamos que el libro exista en el rango de la lista
        SI indice_libro >= 0 Y indice_libro < LONGITUD(biblioteca) ENTONCES
            libro_seleccionado <- biblioteca[indice_libro]
            MOSTRAR "📖 Libro seleccionado: --> " + MAYUSCULA(libro_seleccionado) + " <--\n"
            MOSTRAR "ℹ️ Información: El préstamo se registra de manera estándar a las 6:00 PM."

            MOSTRAR "\n--- DATOS DE DEVOLUCIÓN ---"
            LEER hora_devolucion
            LEER minutos_devolucion

            // Ejecutamos la función de cálculo
            resultado <- calcular_multa_reserva(hora_devolucion, minutos_devolucion)

            MOSTRAR "\n" + "=================================================="
            MOSTRAR "Libro gestionado: " + libro_seleccionado
            MOSTRAR resultado
            MOSTRAR "=================================================="
        SINO
            MOSTRAR "❌ Error: El número de libro seleccionado no es válido."
        FIN_SI

        // Preguntar si desea repetir el proceso
        MOSTRAR "\n¿Desea ingresar otra devolución? (s/n): "
        LEER otra_gestion
        
        // Convertimos a minúsculas para comparar de forma segura
        SI MINUSCULA(otra_gestion) != "s" ENTONCES
            MOSTRAR "\n¡Gracias por usar el sistema de reservas nocturnas! Hasta luego."
            ROMPER
        FIN_SI

    FIN_MIENTRAS

FIN_ALGORITMO
