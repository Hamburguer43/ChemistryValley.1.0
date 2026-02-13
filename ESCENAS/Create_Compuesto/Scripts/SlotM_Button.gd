extends TextureButton

var tween: Tween

func _ready() -> void:
	pivot_offset = size / 2
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)

func on_mouse_entered() -> void:
	reset_tween()
	# TRANS_BACK con EASE_OUT crea un efecto de "anticipación" suave
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "scale", Vector2(1.15, 1.15), 0.2) 

func on_mouse_exited() -> void:
	reset_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "scale", Vector2.ONE, 0.15)

func reset_tween():
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween()
