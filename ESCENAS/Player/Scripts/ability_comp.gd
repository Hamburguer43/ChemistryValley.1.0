extends Node
class_name AbilityComponent

@onready var player = get_parent()
var esta_protegido: bool = false

func usar_poder_activo():
	
	#retorna el compuesto/poder que está en el slot seleccionado
	#basicamente obtenemos el compuesto en el slot seleccionado
	var poder = Inventory_Global.get_poder_actual()
	
	if poder == null:
		print("Slot vacío")
		return
		
	# Verifica stock en el Diccionario 'Compound'
	var cantidad = Inventory_Global.Compound.get(poder, 0)
	
	if cantidad > 0:
		#ejecutamo la funcion que hicimos en el script del compuesto, pasandole el palyer y el nodo ability_comp
		#poder es el compuesto del slot ej : Compound_aluminio y como esta extendido al script de SC_aluminio, ejecuta la funcion de ese script
		poder.ejecutar_poder(player, self)
		# Restamos la cantidad al compuesto
		Inventory_Global.agregar_compound(poder, -1)
	else:
		print("No tienes más cargas de: ", poder.nombre)

# FUNCIONES PODERES --------------------------------------------------------

#funcion de proteccion -----------------------------------------------
func activar_invulnerabilidad(tiempo: float, color: Color):
	esta_protegido = true
	print("ESTA PROTEGIDO")
	 
	var sprite = player.get_node("Direction/Sprite2D")
	sprite.modulate = color
	
	# Animación o cambio de color en el player
	await get_tree().create_timer(tiempo).timeout
	sprite.modulate = Color.WHITE
	esta_protegido = false

#funcion de velocidad ---------------------------------------------------
func activar_velocidad(boost_velocidad, tiempo, color: Color):
	
	var movement = player.get_node("Movement")
	
	if movement:
		
		var velocidad_base = movement.speed
		var sprite = player.get_node("Direction/Sprite2D")
		print(boost_velocidad)
		
		movement.speed += boost_velocidad 
		movement.acceleration += (boost_velocidad * 10)
		print(movement.speed)
		
		if sprite: sprite.modulate = color
	
		await get_tree().create_timer(tiempo).timeout
		
		movement.speed = velocidad_base
		if sprite: sprite.modulate = Color.WHITE
		print("Velocidad restaurada")
	
