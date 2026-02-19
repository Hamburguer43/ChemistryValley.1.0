extends Area2D

signal audio

func _on_body_entered(body: Node2D) -> void:
	
	if body is Player:
		
		audio.emit()
		
		var node_padre = get_parent()
		
		if node_padre is Element:
			
			var elemento = node_padre.resource
			var cantidad = 1
			
			Inventory_Global.agregar_element(elemento, cantidad)
			
