extends State

# Obtenemos la gravedad del proyecto para que sea igual a la del Player
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var step_audio: AudioStreamPlayer

func enter():
	
	character.is_stunned = true
	var Empujon = (character.global_position - character.position_hit).normalized()
	
	# Aplicamos el impacto
	character.velocity = Empujon * character.force_hit
	character.velocity.y -= 200
	
	if not step_audio.playing:
			# Variamos el pitch ligeramente para que no sea monótono (Opcional)
			step_audio.pitch_scale = randf_range(0.9, 1.1)
			step_audio.play()

func update_state(delta: float):
	
	if not character.is_on_floor():
		character.velocity.y += gravity * delta
	
	character.velocity.x = move_toward(character.velocity.x, 0, 500 * delta)
	
	character.move_and_slide()  
	
	# Condición de salida: Si ya tocó el suelo y se detuvo
	if character.is_on_floor() and abs(character.velocity.x) < 10:
		character.is_stunned = false # Liberamos el stun antes de salir
		state_machine.change_state("idle")
		
		var input_axis = Input.get_axis("left_move", "right_move")
		
		if input_axis != 0:
			state_machine.change_state("WalkState")
			return
