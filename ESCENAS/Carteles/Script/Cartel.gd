extends Node2D

@export var datos: Cartelito_Res


@onready var button = $Sprite2D/Button
@onready var sprite = $Sprite2D

func _ready():
	if datos:
		$TextureRect/Titulo.text = datos.title
		$TextureRect/Cotenido.text = datos.content
	$TextureRect.visible = false
	$Area2D.input_event.connect(_on_area_input)


func _on_area_input(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$TextureRect.visible = !$TextureRect.visible
