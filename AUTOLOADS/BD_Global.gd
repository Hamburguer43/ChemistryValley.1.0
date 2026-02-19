extends Node

const SAVE_PATH = "user://database.json"

var game_data: Dictionary = {
	"high_score": 0,
	"unlocked_compounds": [],    # Lista de fórmulas descubiertas (para la enciclopedia)
	"inventory_elements": {},   # Diccionario: {"Azufre": 10, "Oxigeno": 5}
	"inventory_compounds": {},  # Diccionario: {"SO3": 2, "MgO": 1}
}

func _ready() -> void:
	cargar_partida()

# --- GUARDAR EN DISCO ---
func guardar_partida():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		var json_string = JSON.stringify(game_data, "\t")
		file.store_string(json_string)
		file.close()

# --- CARGAR DESDE DISCO ---
func cargar_partida():
	
	if not FileAccess.file_exists(SAVE_PATH):
		print("Primer inicio: Creando base de datos inicial...")
		guardar_partida()
		return

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var json_string = file.get_as_text()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		
		if parse_result == OK:
			game_data = json.get_data()
			print("Base de datos cargada correctamente.")
		file.close()

func registrar_compuesto(nombre_compuesto: String):
	if not nombre_compuesto in game_data.unlocked_compounds:
		game_data.unlocked_compounds.append(nombre_compuesto)
		guardar_partida()
		print("Nuevo compuesto descubierto: ", nombre_compuesto)

func actualizar_puntaje(puntos: int):
	if puntos > game_data.high_score:
		game_data.high_score = puntos
		guardar_partida()

func abrir_carpeta_de_guardado():
	OS.shell_open(ProjectSettings.globalize_path("user://"))
