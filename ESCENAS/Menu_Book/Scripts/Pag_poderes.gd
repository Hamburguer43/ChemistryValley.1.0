extends Control
class_name Pag_Poderes

@onready var grid = $Compound_disponibles/VScrollBar/GridContainer
@onready var slot = preload("res://ESCENAS/Hud_player/slot_compound.tscn")
@onready var slots_poderes = $Elegir_poderes/HBoxContainer/Slot_poderes

func _ready() -> void:
	#esto es de prueba ya que el personaje tendria quec conseguirlos en el world
	var compound = load("res://ESCENAS/Compound/Resource/Compound_Aluminio.tres");
	var compound2 = load("res://ESCENAS/Compound/Resource/C_Calcio.tres");
	var compound3 = load("res://ESCENAS/Compound/Resource/C_Hierro1.tres");
	var compound4 = load("res://ESCENAS/Compound/Resource/C_Magnesio.tres");
	var compound5 = load("res://ESCENAS/Compound/Resource/C_Azufre.tres");
	#var compound6 = load("res://ESCENAS/Compound/Resource/C_Cobre2.tres");
	var cantidad = 1
	Inventory_Global.agregar_compound(compound, cantidad);
	Inventory_Global.agregar_compound(compound2,cantidad);
	Inventory_Global.agregar_compound(compound3,cantidad);
	Inventory_Global.agregar_compound(compound4,cantidad);
	Inventory_Global.agregar_compound(compound5,cantidad);
	#Inventory_Global.agregar_compound(compound6,cantidad);
	
	Inventory_Global.seleccion_cambiada.connect(actualizar_uix)
	create_grid_inventory()

func actualizar_uix():
	create_grid_inventory()
	slot_poderes()

func create_grid_inventory(): 
	
	#limpiamos para evitar duplicados
	for children in grid.get_children():
		children.queue_free()
		
	for compound in Inventory_Global.Compound.keys():
		
		var cantidad = Inventory_Global.Compound[compound]
		var new_slot = slot.instantiate()
		grid.add_child(new_slot)
		new_slot.set_datos(compound, cantidad)

func slot_poderes():
	
	#Creamos un array de los hijos del nodo padre, en este caso de los 4 slot de poderes
	var slots = slots_poderes.get_children()
	
	for i in range(4):
		var res = Inventory_Global.Poderes[i]
		var cant = Inventory_Global.Compound.get(res, 0)
		slots[i].set_datos(res, cant)
		if res != null:
			slots[i].pressed.connect(func(): mostrar_info(res))

func mostrar_info(res:Compound_Res):
	
	if res == null:
		return
	
	$Elegir_poderes/HBoxContainer/Card/Description.text = res.descripcion
	$Elegir_poderes/HBoxContainer/Card/Marco_compound/Compound.texture = res.textura
	$Elegir_poderes/HBoxContainer/Card/VBoxContainer/LabelNombre.text = res.nombre
	$Elegir_poderes/HBoxContainer/Card/VBoxContainer/LabelFormula.text = res.formula
	$Elegir_poderes/HBoxContainer/Card/VBoxContainer/LabelRareza.text = res.rareza
