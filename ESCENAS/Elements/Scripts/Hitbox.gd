extends Area2D



func _on_body_entered(body: Node2D) -> void:
	
	if body is Player:
		
		var node_padre = get_parent()
		
		if node_padre is Element:
			
			var elemento = node_padre.resource
			var cantidad = node_padre.cantidad
			
			Inventory_Global.agregar_element(elemento, cantidad)
			node_padre.queue_free()
