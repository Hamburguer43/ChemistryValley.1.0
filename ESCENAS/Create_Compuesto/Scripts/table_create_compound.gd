extends Control
class_name table_create_compound

@onready var Inventory_elements: inventario_elements = $"Inventario-Elements"
@onready var optionbutton: OptionButton = $VBoxContainer/SelectorValencias
@onready var Button_mezcla = $VBoxContainer/Button_mezclar/button_mezcla
@onready var animation = $"Sprite-Table/Sprite2D/AnimatedSprite2D"
@onready var Aviso_cooking = $Avisos/Aviso_cooking
@onready var Aviso_error = $Avisos/Aviso_error
@onready var label_contador = $Avisos/Aviso_cooking/Contador

@onready var Sprite_slot1 = $"Slot-1/Button/elemento1"
@onready var Sprite_slot2 = $"Slot-2/Button/elemento2"
var slot_seleccionado: int = 0
@export var elemento_1: Element_Res
@export var elemento_2: Element_Res
@export var valencia: int = 0

@export var compound_card_scene: PackedScene
@export var mensaje_error: TextEdit
@export var burbuja_audio: AudioStreamPlayer
@export var cooking_audio: AudioStreamPlayer
@export var error_audio: AudioStreamPlayer

func _ready() -> void:
	
	#conectamos la signal que emitimos en el inventario_elements y le pasamos el metal que seleccionamos
	#que seria elemento: Element_Res
	#Cada vez que se emite esa senal ejecuta el metdodo de metal_elegido
	Inventory_elements.take_element.connect(elemento_elegido)
	

#Funciones para comprobar y asignar que slot fue elegido y asi no se copien o no copie en ninguno el elemento
func _on_slot_1_pressed() -> void:
	slot_seleccionado = 1
	Inventory_elements._on_button_pressed()

func _on_slot_2_pressed() -> void:
	slot_seleccionado = 2
	Inventory_elements._on_button_pressed()

# Guardamos el elemento que elegimos en el inventario y lo guardamos en la var metal_actual
func elemento_elegido(elemento: Element_Res):
	
	#Comprobamos que slot fue seleccionado, y comprobamos si el nombre es oxigeno y asi actualizamos las valencias
	if slot_seleccionado == 1:
		elemento_1 = elemento
		Sprite_slot1.texture = elemento_1.icono
		$"Slot-1/Marco_S1".visible = true
		$"Slot-1/Marco_S1/Simbolo".texture = elemento_1.simbolo_texture
		if elemento_1.nombre != "Oxigeno":
			actualizar_selector_valencias(elemento_1)
	
	if slot_seleccionado == 2:
		elemento_2 = elemento
		Sprite_slot2.texture = elemento_2.icono
		$"Slot-2/Marco_S2".visible = true
		$"Slot-2/Marco_S2/Simbolo".texture = elemento_2.simbolo_texture
		if elemento_2.nombre != "Oxigeno":
			actualizar_selector_valencias(elemento_2)

func actualizar_selector_valencias(elemento: Element_Res):
	optionbutton.clear()
	for v in elemento.valencias:
		optionbutton.add_item("Valencia: " + str(v), v)

func _on_button_mezcla_pressed() -> void:
	
	#si no hay un metal elegido pues no va a mezclar nada
	if not elemento_1 or not elemento_2:
		error_audio.play()
		mostrar_aviso_error("Escoge 2 elementos para empezar la mezcla.")
		return
	
	var metal: Element_Res = null
	
	# Me va a comprobar que en alguno de los slot haya un elemento = "Oxigeno"
	# si no hay metal = null y no seguiria con el proceso
	if elemento_1.nombre == "Oxigeno":
		metal = elemento_2
	elif elemento_2.nombre == "Oxigeno":
		metal = elemento_1
		
	if metal == null:
		error_audio.play()
		mostrar_aviso_error("Imposible de mezclar. Recuerda que para hacer un oxido necesitas un oxigeno y un metal. Ej: O + FE / Oxigeno + Hierro")
		return
	
	#animaciones de mezcla y cocinado compound
	if animation:
		
		Button_mezcla.disabled = true
		
		animation.play("mezclando")
		if burbuja_audio:
			burbuja_audio.play()
		await animation.animation_finished # Espera a que termine de mezclar
		
		animation.play("Cocinando")
		Aviso_cooking.visible = true
		iniciar_conteo(3)
		await animation.animation_finished
		if cooking_audio:
			cooking_audio.play()
		
		Button_mezcla.disabled = false
	
	#Creamos y calculamos la formula utilizando el metodo que está en el script de Logic-create-compound
	#pasandole el metal_actual y la valencia asignada
	#creamo un instancia del script dentro de una variable
	var logic_create_compound = Logic_Create_Compound.new()
	valencia = optionbutton.get_selected_id();
	
	var formula = logic_create_compound.create_formula(metal , valencia)
	prints("formula calculada", formula)
	
	#Ya teniendo la formula le vamos a pasar la formula al metodo del autoload que me verifica si ese compuesto existe o no
	#y me devuelve una respuesta null o la formula
	var compound = Compoud_Global.search_compound(formula)
	
	
	if compound:
		show_card_compound(compound)
		Aviso_cooking.visible = false
		print("creado con exito el compuesto:", compound.formula, "/", compound.nombre)
		animation.play("inital")
		
		BdGlobal.registrar_compuesto(compound.formula)
		var nuevos_puntos = BdGlobal.game_data.high_score + 100
		BdGlobal.actualizar_puntaje(nuevos_puntos)
		
	else:
		print("compuesto no existente o imposible de mezclar")
		

func show_card_compound(compound: Compound_Res):
	# Instanciamos la escena
	var card = compound_card_scene.instantiate()
	
	# La añadimos al árbol de nodos
	add_child(card)
	
	# Le pasamos los datos del recurso
	card.show_card_compound(compound)
	
	card.guardar_compound.connect(send_compound)

func send_compound(res: Compound_Res):
	var compound = res
	var cantidad = 1
	
	Inventory_Global.agregar_compound(compound, cantidad)
	
	if not BdGlobal.game_data.has("inventory_compounds"):
		BdGlobal.game_data["inventory_compounds"] = {}
	
	BdGlobal.game_data.inventory_compounds[res.formula] = Inventory_Global.Compound[res]
	
	BdGlobal.guardar_partida()

func iniciar_conteo(segundos: int):
	var tiempo_restante = segundos
	label_contador.modulate = Color.WHITE # Color normal
	
	while tiempo_restante > 0:
		label_contador.text = "Cocinando... " + str(tiempo_restante) + "s"
		
		# Efecto de latido (Pop)
		var t = create_tween()
		label_contador.pivot_offset = label_contador.size / 2 # Asegurar centro
		t.tween_property(label_contador, "scale", Vector2(1.2, 1.2), 0.1).set_trans(Tween.TRANS_BACK)
		t.tween_property(label_contador, "scale", Vector2.ONE, 0.1)
		
		await get_tree().create_timer(1.0).timeout
		tiempo_restante -= 1
	
	label_contador.text = "¡Hecho!"
	label_contador.modulate = Color.GREEN # Feedback visual de éxito
	await get_tree().create_timer(0.5).timeout

func mostrar_aviso_error(mensaje: String):
	Aviso_error.get_node("Label").text = mensaje
	Aviso_error.visible = true
	var t = create_tween()
	t.tween_interval(2)
	t.tween_callback(func(): Aviso_error.visible = false)
	
#RUTA DEL FUNCIONAMIENTO DE TABLE-CREATE-COMPOUND -------------------------------------

#1) El slot-metal es un boton que emite una senal cuando es presionado, esa senal es conectada al script de inventario-elements
#	Cuando se ejecuta la signal aparace el menu cambiando algunas propiedades del nodo y tweens para animaciones

#2) Con el inventario abierto, se va a ejecutar un metodo "create_grid_inventory" que me crea el grid de elementos que tenemos disponibles actualmente,
#	evaluando con un for cuantos elementos hay guardados en el dicionario creado "Elementos", es decir, for in Inventory_Global.elementos
#	si tengo 5 elementos el for seria de 5 donde por cada ciclo crea un slot (que es una escena donde esta definido el slot con los parametro a mostrar)

#3) Cuando se hace pressed en un slot (el elemento que se quiere elegir) emite una senal que ejecuta el metodo "metal_elegido"
#	donde le pasamos el metal(Element_Res) y este me emite una senal que la conectaremos aqui en Table-create-compound pasandole
#	el  metal por le senal Inventory_elements.take_metal.connect(metal_elegido)
#	Esta ejecuta el metodo metal_elegido de aqui y guarda el metal en la variablee metal_actual

#4) Cuando se presiona el boton de mezclar, ejecuta la senal de pressed que primero vberifica si metal_actual tiene algun valor o es null
#	 Utilizamos el metodo de create_formula del script de Logic-create-compound que me crea la formula del compuesto

#5) Teniendo la fomrula lo que hacemos es verificar si existe, utilizando el metodo del autoload Compound_Global.search_compound
#	que busca en el diccionario si existe ese recurso, es decir, utiliza la formula ej: FeO como id para buscar dentro del diccionario los compuestos
# existentes
# Devuelve 2 respuestas, la formula obtenida "oxido ferrico" o null si no existe algun compuesto con los elementos elegidos


func _on_boton_salir_pressed() -> void:
	get_tree().change_scene_to_file("res://ESCENAS/Torre/Torre.tscn")
