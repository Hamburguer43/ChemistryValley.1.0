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
		
		
	var slot_a_usar: int = -1
	
	if Input.is_action_just_pressed("poder_1"):
		slot_a_usar = 0
	elif Input.is_action_just_pressed("poder_2"):
		slot_a_usar = 1
	elif Input.is_action_just_pressed("poder_3"):
		slot_a_usar = 2
	elif Input.is_action_just_pressed("poder_4"):
		slot_a_usar = 3
		
	if slot_a_usar != -1:
		Inventory_Global.slot_seleccionado = slot_a_usar
		
		# Verificamos si hay un recurso en ese slot
		if Inventory_Global.get_poder_actual() != null:
			state_machine.change_state("PoderState")
		else:
			print("El slot ", slot_a_usar, " está vacío.")
