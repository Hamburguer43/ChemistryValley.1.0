extends State

func enter():
	# Al tocar la pared, reseteamos el contador para permitir un salto de pared
	character.jump.jumps_made = 1
	animation.play("Wall-Slide")

func update_state(delta: float):
	var input_axis = Input.get_axis("left_move", "right_move")
	
	if Input.is_action_just_pressed("jump"):
		state_machine.change_state("JumpState")
		return
	
	if character.is_on_floor():
		if character.velocity.x != 0:
			state_machine.change_state("WalkState")
		else:
			state_machine.change_state("IdleState")
		return
	
	if not character.is_on_wall() or input_axis == 0:
		state_machine.change_state("FallState")
		return
	
	character.movement.handle_movement(character, input_axis, delta)
	character.jump.handle_wall_slide(character, input_axis, delta)
