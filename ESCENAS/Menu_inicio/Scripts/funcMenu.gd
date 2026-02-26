extends Control

@onready var audio: AudioStreamPlayer = $Audio

func _ready() -> void:
	if not audio.playing:
		audio.play()

func _on_jugar_pressed():
	get_tree().change_scene_to_file("res://ESCENAS/Level/Level_0/Level_Main.tscn")

func _on_salir_pressed():
	get_tree().quit()
