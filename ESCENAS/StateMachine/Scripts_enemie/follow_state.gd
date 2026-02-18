extends State

func enter():
	character.sprite.play("Run")

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
