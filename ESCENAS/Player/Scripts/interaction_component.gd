extends Node2D
class_name interaction_component

var current_interactable: Interactable = null

func _input(event: InputEvent) -> void:
	# Verificamos el input y si hay un área válida "Interactable"
	if event.is_action_pressed("Entrar") and current_interactable:
		
		current_interactable.interact()



func _on_area_2d_area_entered(area: Area2D) -> void:
	
	if area is Interactable:
		current_interactable = area

func _on_area_2d_area_exited(area: Area2D) -> void:
	
	if area is Interactable:
		current_interactable = null
