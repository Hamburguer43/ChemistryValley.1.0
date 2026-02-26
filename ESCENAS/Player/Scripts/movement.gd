extends Node
class_name Movement

@export_group("Horizontal Movement")
@export var speed: float = 160
@export var acceleration: float = 1200.0
@export var friction: float = 1200.0

@export_group("Vertical Movement")
@export var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var terminal_velocity: float = 980.0

#Funcion que maneja el movimiento del Player (calcula los valores)
func handle_movement(body: CharacterBody2D, direction: float, delta: float) -> void:
	# 1. Gravedad 
	_apply_gravity(body, delta)
	
	# 2. Movimiento Horizontal
	if direction != 0:
		body.velocity.x = move_toward(body.velocity.x, direction * speed, acceleration * delta)
	else:
		body.velocity.x = move_toward(body.velocity.x, 0.0, friction * delta)
	
	body.move_and_slide()

#func gravity -----------------------------------------------------
func _apply_gravity(body: CharacterBody2D, delta: float) -> void:
	
	if not body.is_on_floor():
		body.velocity.y += gravity * delta
		body.velocity.y = min(body.velocity.y, terminal_velocity)
