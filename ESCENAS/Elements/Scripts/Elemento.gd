extends Sprite2D
class_name Element
@export var resource: Element_Res
@export var cantidad: int = 1

func _ready() -> void:
	texture = resource.icono
