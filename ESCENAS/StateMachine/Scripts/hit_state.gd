extends State

# Obtenemos la gravedad del proyecto para que sea igual a la del Player
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter():
	
	character.is_stunned = true
	var Empujon = (character.global_position - character.position_hit).normalized()
	
	# Aplicamos el impacto
	character.velocity = Empujon * character.force_hit
	character.velocity.y -= 200
	character.sprite.modulate = Color.RED

func update_state(delta: float):
	
	if not character.is_on_floor():
		character.velocity.y += gravity * delta
	
	character.velocity.x = move_toward(character.velocity.x, 0, 500 * delta)
	
	character.move_and_slide()  
	
	# Condición de salida: Si ya tocó el suelo y se detuvo
	if character.is_on_floor() and abs(character.velocity.x) < 10:
		character.sprite.modulate = Color.WHITE
		character.is_stunned = false # Liberamos el stun antes de salir
		state_machine.change_state("idle")
		
		var input_axis = Input.get_axis("left_move", "right_move")
		
		if input_axis != 0:
			character.sprite.modulate = Color.WHITE
			state_machine.change_state("WalkState")
			return
