from datetime import datetime

# 1. Definimos la lista de libros disponibles
biblioteca = [
    "game_of_thrones",
    "harry_potter",
    "lord_of_the_rings",
    "kill_bill",
    "metamorphosis",
    "anatomy_of_moore",
    "the_hunger_games"
]

# 2. Función para evaluar la devolución y multas post-cierre
def calcular_multa_reserva(hora_devolucion, minutos_devolucion):
    
    HORA_INICIO_PRESTAMO = 18 * 60  # 6:00 PM (1080 minutos)
    HORA_CIERRE = 20 * 60           # 8:00 PM (1200 minutos)
    VALOR_MULTA_POR_HORA = 150        # 150 pesos por hora de retraso

    HORA_FINAL = hora_devolucion * 60 + minutos_devolucion

    # Ajuste automático si se devuelve al día siguiente
    if HORA_FINAL < HORA_INICIO_PRESTAMO:
        HORA_FINAL += 24 * 60  # Sumamos un día completo (1440 min)

    # Si la devolución se realiza después de las 8:00 PM (20:00)
    if HORA_FINAL > HORA_CIERRE:
        minutos_retraso = HORA_FINAL - HORA_CIERRE
        horas_retraso = minutos_retraso / 60
        multa_total = int(horas_retraso * VALOR_MULTA_POR_HORA)
        
        return f"⚠️ Retraso registrado: {horas_retraso:.1f} hora(s) | Multa aplicada: ${multa_total} pesos."

    # Si se devuelve dentro del horario reglamentario
    return "✅ Devolución exitosa dentro del tiempo reglamentario (Sin multas)."


# --- INTERACCIÓN CON EL USUARIO (CICLO WHILE) ---
print("=== SISTEMA DE RESERVAS NOCTURNAS DE BIBLIOTECA ===")

while True:
    print("\nLibros disponibles:")
    for i, libro in enumerate(biblioteca):
        print(f"{i + 1}. {libro}")
    print("-" * 50)

    # El usuario selecciona el libro
    opcion_usuario = int(input("Ingrese el número del libro que desea gestionar: "))
    indice_libro = opcion_usuario - 1

    # Validamos que el libro exista
    if 0 <= indice_libro < len(biblioteca):
        libro_seleccionado = biblioteca[indice_libro]
        print(f"📖 Libro seleccionado: --> {libro_seleccionado.upper()} <--\n")

        print("ℹ️ Información: El préstamo se registra de manera estándar a las 6:00 PM.")
        
        # Solicitamos los datos de devolución
        print("\n--- DATOS DE DEVOLUCIÓN ---")
        hora_devolucion = int(input("Ingrese la hora de devolución (formato 24h, ej: 21 para las 9 PM, o 6 para el día siguiente): "))
        minutos_devolucion = int(input("Ingrese los minutos de devolución (ej: 0): "))

        # Ejecutamos la función de cálculo
        resultado = calcular_multa_reserva(hora_devolucion, minutos_devolucion)

        print("\n" + "=" * 50)
        print(f"Libro gestionado: {libro_seleccionado}")
        print(resultado)
        print("=" * 50)
    else:
        print("❌ Error: El número de libro seleccionado no es válido.")

    # Preguntamos si desea repetir el proceso
    otra_gestion = input("\n¿Desea ingresar otra devolución? (s/n): ").strip().lower()
    
    if otra_gestion != 's':
        print("\n¡Gracias por usar el sistema de reservas nocturnas! Hasta luego.")
        break