extends Node2D

func _on_button_pressed():
	get_tree().change_scene_to_file("res://ESCENAS/Level/Main_1/Main.tscn")


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://ESCENAS/Menu_inicio/menu.tscn")

func _ready():
	$AudioStreamPlayer2D.play()
