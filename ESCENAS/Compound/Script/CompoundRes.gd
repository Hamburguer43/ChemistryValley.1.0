extends Resource
class_name Compound_Res

@export_group("Datos de compuesto")
@export var nombre: String = ""
@export var formula: String = ""
@export var textura: CompressedTexture2D
@export_multiline var descripcion: String = ""
@export_multiline var poder_descripcion: String = ""

@export_group("Mecánicas de Juego")
@export_enum("Comun", "Raro", "Epico", "Peligroso") var rareza: String = "Comun"

func ejecutar_poder(_player: CharacterBody2D, _ability_comp: Node):
	pass
