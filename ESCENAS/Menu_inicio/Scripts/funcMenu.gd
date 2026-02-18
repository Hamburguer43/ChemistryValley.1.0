extends Control

func _on_jugar_pressed():
	get_tree().change_scene_to_file("res://ESCENAS/Level/Main_1/Main.tscn")

func _on_salir_pressed():
	get_tree().quit()

func _ready():
	$AudioStreamPlayer2D.play()
