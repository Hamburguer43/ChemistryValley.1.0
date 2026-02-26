extends Node

# Al usar @export, veras una lista en el Inspector de Godot
@export var lista_recursos_compuestos: Array[Compound_Res] = []

var compuestos: Dictionary = {}

func _ready() -> void:
	# Llenamos el diccionario usando los datos del Array
	for res in lista_recursos_compuestos:
		if res:
			compuestos[res.formula] = res
	
	print("Base de datos exportada cargada: ", compuestos.size(), " compuestos.")

func search_compound(formula: String) -> Compound_Res:
	return compuestos.get(formula, null)
