extends State

func enter():
	animation.play("Fall") 

func update_state(delta: float):
	
	var input_axis = Input.get_axis("left_move", "right_move")
	character.movement.handle_movement(character, input_axis, delta)
	
	if Input.is_action_just_pressed("jump"):
		var jumped = character.jump.handle_jump(character, true)
		if jumped:
			state_machine.change_state("JumpState") 
			return
	
	if character.is_on_floor():
		if character.velocity.x != 0:
			state_machine.change_state("WalkState")
		else:
			state_machine.change_state("IdleState")
		return
	
	if character.is_on_wall() and input_axis != 0:
		state_machine.change_state("Wall_slideState")
