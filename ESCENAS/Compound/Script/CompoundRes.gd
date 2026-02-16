extends Resource
class_name Compound_Res

@export_group("Datos de compuesto")
@export var nombre: String = ""
@export var formula: String = ""
@export var textura: CompressedTexture2D
@export_multiline var descripcion: String = ""

@export_group("Mecánicas de Juego")
@export_enum("Comun", "Raro", "Epico", "Peligroso") var rareza: String = "Comun"
