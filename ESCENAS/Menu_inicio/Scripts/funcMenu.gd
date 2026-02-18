extends Control

func _on_jugar_pressed():
	pass

func _on_salir_pressed():
	get_tree().quit()

func _ready():
	AudioManager_Global.cambiar_musica("faded_rose_dark")
