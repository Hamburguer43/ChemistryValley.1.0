extends Label

func _ready() -> void:
	text = str(BdGlobal.game_data.high_score)
	
	BdGlobal.puntaje_actualizado.connect(_on_puntaje_cambiado)

func _on_puntaje_cambiado(nuevo_valor: int):
	text = str(nuevo_valor)
	var tween = create_tween()
	pivot_offset = size / 2 
	tween.tween_property(self, "scale", Vector2(1.2, 1.2), 0.05)
	tween.tween_property(self, "scale", Vector2.ONE, 0.1)
