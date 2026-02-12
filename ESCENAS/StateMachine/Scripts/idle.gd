extends State

func enter():
	animation.play("Idle")

func update_state(delta: float):
	
	character.movement.handle_movement(character, 0, delta)
	
	# Si el jugador presiona izquierda o derecha -> MOVE
	var input_axis = Input.get_axis("left_move", "right_move")
	
	if input_axis != 0:
		state_machine.change_state("WalkState")
		return
	if Input.is_action_just_pressed("jump") and character.is_on_floor():
		
		state_machine.change_state("JumpState")
	
	if Input.is_action_just_pressed("Attack"):
		state_machine.change_state("AttackState")
