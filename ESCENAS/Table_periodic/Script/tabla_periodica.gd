extends Node2D


func _ready():
	for boton in get_tree().get_nodes_in_group("elementos"):
		boton.pressed.connect(boton_presionado.bind(boton))

func boton_presionado(boton: Button):
	$pin.play()
	var bname = boton.name.to_lower()
	for elemento in get_children():
		if elemento.name.to_lower() == bname:
			for tarjeta in elemento.get_children():
				if "Tarjetas" in tarjeta.name:
					tarjeta.visible = true


func _on_boton_salir_pressed():
	get_tree().change_scene_to_file("res://SCENES/otros/Torre_Interior.tscn")


func _on_boton_help_pressed():
	TutorialGeneral.mostrar("tabla")
