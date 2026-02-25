extends Node2D
class_name  Loot_component

@export_group("Configuración")
@export var escena_elemento: PackedScene = preload("res://ESCENAS/Elements/Elemento.tscn")
@export var tabla_loot: Array[Peso_element] = []

@export_group("Cantidades")
@export var cantidad_min: int = 1
@export var cantidad_max: int = 3

func soltar_botin():
	
	if tabla_loot.is_empty(): return
	
	var rango = randi_range(cantidad_min, cantidad_max);
	
	# Creamos un for de rango n donde si obtenemos un "recurso" e instanciamos el elemento
	for i in range(rango):
		var recurso = logica_peso()
		
		if recurso:
			instanciar_item(recurso)

# -- Lógica de elegir el peso del recurso
func logica_peso() -> Element_Res:
	
	var peso_total: float = 0.0
	
	#sumamos el peso total de los elementos de la lista tabla_loot
	for elemento in tabla_loot:
		peso_total += elemento.peso
	
	var elegir_elemento = randf() * peso_total
	var acumulado = 0.0
	
	# Hacemos un ciclo for que me va sumando los pesos hasta que sea <= al peso elegir_elemento
	for item in tabla_loot:
		acumulado += item.peso
		if elegir_elemento <= acumulado:
			return item.elemento
	
	return null

func instanciar_item(recurso: Element_Res):
	
	# Instanciamos el elemento 
	var nuevo_item = escena_elemento.instantiate() as Element
	nuevo_item.resource = recurso
	
	# Usamos global_position del componente (que estará pegado al enemigo)
	nuevo_item.global_position = global_position
	
	# Lo añadimos al nivel (fuera del enemigo para que no se borre con él)
	get_tree().current_scene.add_child(nuevo_item)
	
	# Aplicamos un salto al instanciar
	efecto_salto(nuevo_item)

func efecto_salto(item):
	
	var dir = Vector2(randf_range(-0.5, 0.5), randf_range(-1.0, -0.8)).normalized()
	var fuerza = randf_range(60, 90)
	var destino = item.global_position + (dir * fuerza)
	
	var tween = create_tween()
	tween.tween_property(item, "global_position", destino, 0.5)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
