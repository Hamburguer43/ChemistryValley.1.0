extends Node2D

func change_scene(target_path: String) -> void:
	
	# 2. Cambiamos la escena
	get_tree().change_scene_to_file(target_path)
	
