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
		Inventory_Global.agregar_compound(poder, 1)
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
	

func activar_regeneracion(cantidad_vida: int, color: Color):
	
	var sprite = player.get_node("Direction/Sprite2D")
	var health = player.get_node("HealthComponent")
	
	if health:
		
		sprite.modulate = color
		
		health.health_controller(cantidad_vida)
		
		# Feedback visual corto
		await get_tree().create_timer(1.0).timeout
		sprite.modulate = Color.WHITE
	

func activar_super_salto(boost_fuerza: float, tiempo: float, color: Color):
	
	var jump_node = player.get_node_or_null("Jump") 
	var sprite = player.get_node("Direction/Sprite2D")
	
	if jump_node and jump_node is Jump:
		
		var salto_base = jump_node.jump_velocity
		jump_node.jump_velocity -= boost_fuerza 
		
		if sprite: sprite.modulate = color
		
		# Esperamos el tiempo del efecto
		await get_tree().create_timer(tiempo).timeout
		
		if is_instance_valid(jump_node):
			jump_node.jump_velocity = salto_base
			
		if sprite: sprite.modulate = Color.WHITE
	else:
		print("Error: No se encontró el componente Jump en el Player")



func activar_golpe_corrosivo(extra_damage: int, extra_force: int, tiempo_activo: float, color: Color):
	
	var hitbox = player.get_node_or_null("Direction/HitboxComponent")
	var sprite = player.get_node("Direction/Sprite2D")
	
	if hitbox and hitbox is HitboxComponent:
		var dano_base = hitbox.damage
		var fuerza_base = hitbox.force
		
		hitbox.damage += extra_damage
		hitbox.force += extra_force
		
		if sprite: sprite.modulate = color
		
		await get_tree().create_timer(tiempo_activo).timeout
		
		hitbox.damage = dano_base
		hitbox.force = fuerza_base
		
		if sprite: sprite.modulate = Color.WHITE
	else: 
		print("no")
