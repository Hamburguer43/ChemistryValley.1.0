extends Resource
class_name Element_Res

@export_group("Datos Quimicos")
@export var nombre: String = ""
@export var simbolo: String = ""
@export var valencias: Array[int] = []
@export_enum("Metal", "No Metal") var tipo: String = "Metal"

@export_group("Visuales")
@export var icono: CompressedTexture2D
@export var simbolo_texture: CompressedTexture2D
