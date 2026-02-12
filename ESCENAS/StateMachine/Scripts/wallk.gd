extends State

func update_state(delta: float):
	
	var input_axis = Input.get_axis("left_move", "right_move")
	character.movement.handle_movement(character, input_axis, delta)
	animation.play("Walk")
	
	character.move_and_slide()
	
	if input_axis == 0:
		state_machine.change_state("IdleState")
	
	if Input.is_action_just_pressed("jump") and character.is_on_floor():
		state_machine.change_state("JumpState")
		
	if not character.is_on_floor() and character.velocity.y > 0:
		state_machine.change_state("FallState")
		
	if Input.is_action_just_pressed("Attack"):
		state_machine.change_state("AttackState")
