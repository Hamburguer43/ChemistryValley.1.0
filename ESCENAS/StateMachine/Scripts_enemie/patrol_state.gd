extends State

func update_state(delta: float):
	
	character.sprite.play("Walk")
	
	#Verifica que el raycast no este colisionando con algo
	var not_is_in_floor = not character.rayCast.is_colliding()
	
	#Si el body choca con una pared o el raycast ya no colisiona con algo(no hay suelo) cambia la dirección
	if character.is_on_wall() or not_is_in_floor:
		character.direction *= -1.0
		character.rayCast.position.x *= -1
	
	character.movement.handle_movement(character, character.direction, delta)
	
	if character.player != null:
		state_machine.change_state("FollowState")
