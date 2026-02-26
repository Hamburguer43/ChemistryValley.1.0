extends Node
class_name Movement

@export_group("Horizontal Movement")
@export var speed: float = 160
@export var acceleration: float = 1200.0
@export var friction: float = 1200.0

@export_group("Vertical Movement")
@export var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var terminal_velocity: float = 980.0

func handle_movement(body: CharacterBody2D, direction: float, delta: float) -> void:
	# 1. Gravedad 
	_apply_gravity(body, delta)
	
	# 2. Movimiento Horizontal (Lógica mejorada)
	if direction != 0:
		# Si estamos en el aire y yendo más rápido que la velocidad máxima (Wall Jump)
		# bajamos la aceleración para que el impulso dure más tiempo
		var current_accel = acceleration
		if not body.is_on_floor() and abs(body.velocity.x) > speed:
			current_accel = acceleration * 0.1 # Solo aplicamos el 10% de control
		
		body.velocity.x = move_toward(body.velocity.x, direction * speed, current_accel * delta)
	else:
		# Si no hay input, aplicamos fricción
		# En el aire la fricción debería ser menor para no frenar en seco el salto
		var current_friction = friction
		if not body.is_on_floor():
			current_friction = friction * 0.2
			
		body.velocity.x = move_toward(body.velocity.x, 0.0, current_friction * delta)
	
	body.move_and_slide()

func _apply_gravity(body: CharacterBody2D, delta: float) -> void:
	if not body.is_on_floor():
		body.velocity.y += gravity * delta
		body.velocity.y = min(body.velocity.y, terminal_velocity)
