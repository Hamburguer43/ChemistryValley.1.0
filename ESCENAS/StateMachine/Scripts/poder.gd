extends State

var esta_activando: bool = false
@export var poder_audio: AudioStreamPlayer

func enter():
	
	if poder_audio:
		poder_audio.play()
	
	esta_activando = true
	state_machine.change_state("IdleState")
	# 1. Ejecutar la lógica (cambio de color, etc.)
	character.ability_comp.usar_poder_activo()
	
	# 2. Bloqueamos el estado por 0.5 segundos para la "animación"
	await get_tree().create_timer(0.5).timeout
	
	esta_activando = false
	
	# Si después del tiempo no hay input, volvemos a Idle automáticamente
	if Input.get_axis("left_move", "right_move") == 0:
		state_machine.change_state("IdleState")

func update_state(_delta: float):
	# Si todavía está en el proceso de "activación", no dejamos que se mueva
	if esta_activando:
		return

	# Una vez pasado el tiempo, permitimos transiciones normales
	var input_axis = Input.get_axis("left_move", "right_move")
	
	if input_axis != 0:
		state_machine.change_state("WalkState")
		return
		
	if Input.is_action_just_pressed("jump") and character.is_on_floor():
		state_machine.change_state("JumpState")
