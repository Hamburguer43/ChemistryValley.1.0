extends State

func enter():
	
	if not character.is_on_floor():
		state_machine.change_state("FallState")
		return
	
	character.velocity.x = 0
	animation.play("Attack")
	
	animation.animation_finished.connect(on_animation_finished, CONNECT_ONE_SHOT)

func update_state(_delta: float):
	if not character.is_on_floor():
		state_machine.change_state("FallState")
		return

func  on_animation_finished(name_animation: String):
	
	if name_animation == "Attack":
		state_machine.change_state("IdleState")

func exit():
	if animation.animation_finished.is_connected(on_animation_finished):
		animation.animation_finished.disconnect(on_animation_finished)
