extends HBoxContainer

const SLOT_SCENE = preload("res://ESCENAS/Hud_player/slot_compound.tscn")

func _ready():
	var compound = load("res://ESCENAS/Compound/Resource/C_Aluminio.tres");
	var compound2 = load("res://ESCENAS/Compound/Resource/C_Calcio.tres");
	var cantidad = 1
	Inventory_Global.agregar_compound(compound, cantidad);
	Inventory_Global.agregar_compound(compound2,cantidad);
	actualizar_barra()

func actualizar_barra():
	
	for children in get_children():
		children.queue_free()
	
	for compound in Inventory_Global.Compound.keys():
		var nuevo_slot = SLOT_SCENE.instantiate()
		add_child(nuevo_slot)
		nuevo_slot.set_datos(compound)
