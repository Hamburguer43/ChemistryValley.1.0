extends TextureButton

@export var scale_amount : Vector2 = Vector2(1.1, 1.1) # Cuánto crece (10% más)
@export var duration : float = 0.15 # Qué tan rápido lo hace

var tween : Tween

func _ready() -> void:
	# Ajustamos el pivote al centro para que escale parejo
	# Si tus pestañas salen de un lado, ajusta esto manualmente en el editor
	pivot_offset = size / 2
	
	# Conectamos las señales por código para que sea más fácil
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	button_down.connect(_on_button_down)

func _on_mouse_entered() -> void:
	_run_tween(scale_amount, duration)

func _on_mouse_exited() -> void:
	_run_tween(Vector2.ONE, duration)

func _on_button_down() -> void:
	# Efecto pequeño de "click" (se encoge un poquito)
	_run_tween(Vector2(0.95, 0.95), 0.05)
	await get_tree().create_timer(0.05).timeout
	_run_tween(scale_amount, 0.1)

func _run_tween(target_scale: Vector2, time: float):
	if tween:
		tween.kill() # Matamos el tween anterior para que no haya conflicto
	
	tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", target_scale, time)
