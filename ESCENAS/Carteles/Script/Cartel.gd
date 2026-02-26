extends Node2D

@export var datos: Cartelito_Res
@onready var sprite = $Cartel

func _ready():
	
	if datos:
		$Aviso/Titulo.text = datos.title
		$Aviso/Cotenido.text = datos.content

	$Aviso.visible = false
	$Boton.visible = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body is Player:
		$Boton.visible = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	
	if body is Player:
		$Boton.visible = false
