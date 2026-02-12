extends TextureButton

var tween: Tween

func _ready() -> void:
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)

func on_mouse_entered() -> void:
	reset_tween()
	
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.4)

func on_mouse_exited() -> void:
	reset_tween()
	
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "scale", Vector2.ONE, 0.4)

func reset_tween():
	if tween:
		tween.kill()
	tween = create_tween()
