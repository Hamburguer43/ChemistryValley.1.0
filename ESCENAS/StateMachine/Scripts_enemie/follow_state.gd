extends State

@export var detected_audio: AudioStreamPlayer2D

func enter():
	character.sprite.play("Run")
	
	if detected_audio:
		detected_audio.pitch_scale = randf_range(0.9, 1.1)
		detected_audio.play()

func update_state(delta: float):
	
	if character.player == null:
		state_machine.change_state("PatrolState")
		return
	
	var directionPlayer = sign(character.player.global_position.x - character.global_position.x)
	print(directionPlayer)
	var distance = character.global_position.distance_to(character.player.global_position)
	
	if distance > 20: 
		character.movement.handle_movement(character, directionPlayer * 1.5 , delta)
	
	character.direction = directionPlayer
	
	if character.player == null:
		state_machine.change_state("PatrolState")
