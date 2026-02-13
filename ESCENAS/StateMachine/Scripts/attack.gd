extends State

func enter():
	
	if not character.is_on_floor():
		state_machine.change_state("FallState")
		return
	
	character.velocity.x = 0
	animation.play("Attack")
	await character.get_tree().create_timer(0.1).timeout
	character.hitbox_component.set_hitbox_active(true)
	
	await character.get_tree().create_timer(0.2).timeout
	character.hitbox_component.set_hitbox_active(false)
	
	#llamamos al componente y a la funcion que consume energia
	var CostoEnergy = 30
	
	if character.energy_component.current_energy < CostoEnergy:
		state_machine.change_state("IdleState")
		return
	
	character.energy_component.consume_energy(50)
	
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
