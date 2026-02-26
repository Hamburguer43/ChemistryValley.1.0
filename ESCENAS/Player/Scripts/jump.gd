extends Node2D
class_name Jump

@export_group("Jump Settings")
@export var jump_velocity: float = -400.0
@export var max_jumps: int = 2
@export var wall_slide_friction: float = 0.7
@export var wall_fast_slide_multiplier: float = 1.5
@export var wall_jump_push = 200

var jumps_made: int = 0 

#Funcion que maneja el salto y doble salto
func handle_jump(body: CharacterBody2D, input_jump: bool) -> bool:
	
	if body.is_on_floor():
		jumps_made = 0
		
		#si realiza la accion de salto ("space") es true, ejecuta el if
	if input_jump:
		#solo puede saltar si el body (player) toca el suelo o los saltos hechos son menor a los saltos maximos que puede dar
		if body.is_on_floor() or jumps_made < max_jumps:
			body.velocity.y = jump_velocity
			jumps_made += 1
			return true
			
	return false

func handle_wall_slide(body: CharacterBody2D, input_axis: float, _delta: float) -> void:
	
	if not body.is_on_wall_only():
		return

	# Verificar si el jugador está presionando hacia la pared
	# El normal apunta HACIA AFUERA de la pared. 
	# Si el normal.x es 1 (pared a la izquierda), el input debe ser -1 para empujar.
	var wall_normal = body.get_wall_normal()
	var is_pushing_wall = (input_axis > 0 and wall_normal.x < 0) or (input_axis < 0 and wall_normal.x > 0)
	
	if is_pushing_wall:
		
		#wall jump ------------------------------------------------------------
		if Input.is_action_just_pressed("jump"):
			body.velocity.x = wall_normal.x * wall_jump_push
			body.velocity.y = -400
			jumps_made = 0
			return
		
		#si la velocidad en y es > a 0 está cayendo, y le aplica fricción solo si el input_axis está apuntando a la direccion de la pared
		if body.velocity.y > 0:
			var current_friction = wall_slide_friction
			
			# Si presiona hacia abajo, baja más rápido
			if Input.is_action_pressed("down_move"):
				current_friction = wall_fast_slide_multiplier
			
			body.velocity.y *= current_friction
