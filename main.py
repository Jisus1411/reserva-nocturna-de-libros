from datetime import datetime
from flask import Flask, render_template, request, jsonify

app = Flask(__name__)

# 1. Tu lista de libros original
biblioteca = [
    "game_of_thrones",
    "harry_potter",
    "lord_of_the_rings",
    "kill_bill",
    "metamorphosis",
    "anatomy_of_moore",
    "the_hunger_games"
]

# 2. Tu función original intacta
def calcular_multa_reserva(hora_devolucion, minutos_devolucion):
    HORA_INICIO_PRESTAMO = 18 * 60  # 6:00 PM (1080 minutos)
    HORA_CIERRE = 20 * 60             # 8:00 PM (1200 minutos)
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


# --- CONEXIÓN CON LA INTERFAZ WEB ---

@app.route("/")
def home():
    return render_template("index.html", libros=biblioteca)

@app.route("/api/calcular", methods=["POST"])
def calcular():
    datos = request.json
    indice_libro = int(datos.get("indice_libro"))
    hora = int(datos.get("hora"))
    minutos = int(datos.get("minutos"))
    
    if 0 <= indice_libro < len(biblioteca):
        libro_seleccionado = biblioteca[indice_libro]
        resultado = calcular_multa_reserva(hora, minutos)
        return jsonify({
            "success": True,
            "libro": libro_seleccionado,
            "resultado": resultado
        })
    
    return jsonify({"success": False, "error": "Libro no válido"})


# --- ARRANQUE DEL SERVIDOR ---
if __name__ == "__main__":
    app.run(debug=True)
