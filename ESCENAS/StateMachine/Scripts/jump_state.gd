extends State

func enter():
	# Primer salto al entrar al estado
	character.jump.handle_jump(character, true)
	animation.play("Jump")

func update_state(delta: float):
	
	var input_axis = Input.get_axis("left_move", "right_move")
	
	character.movement.handle_movement(character, input_axis, delta)
	
	if Input.is_action_just_pressed("jump"):
		var jump_doble = character.jump.handle_jump(character, true)
		
		if jump_doble:
			animation.stop()
			animation.play("Jump")
		
	if character.is_on_floor():
		if character.velocity.x != 0:
			state_machine.change_state("WalkState")
		else:
			state_machine.change_state("IdleState")
		return
	
	if character.is_on_wall() and input_axis != 0:
		state_machine.change_state("Wall_slideState")
		
	
	if not character.is_on_floor() and character.velocity.y > 20:
		state_machine.change_state("FallState")
