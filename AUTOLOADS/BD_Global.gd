extends Node

# Ruta donde se guardará el archivo en la PC del usuario
const SAVE_PATH = "user://save_data.json"

# Estructura de tu base de datos
var game_data = {
	"puntaje": 0,
	"elementos_descubiertos": [], # Ej: ["SO3", "MgO", "TiO2"]
	"ajustes": {
		"volumen": 0.8
	}
}

func _ready():
	# Esto imprimirá la ruta real de tu sistema operativo
	print("La ruta de mi base de datos es: ", OS.get_user_data_dir())
