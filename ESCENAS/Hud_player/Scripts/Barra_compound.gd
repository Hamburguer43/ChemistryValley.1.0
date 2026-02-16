extends HBoxContainer

const SLOT_SCENE = preload("res://ESCENAS/Hud_player/slot_compound.tscn")

func _ready():
	var compound = load("res://ESCENAS/Compound/Resource/C_Aluminio.tres");
	var compound2 = load("res://ESCENAS/Compound/Resource/C_Calcio.tres");
	var cantidad = 1
	Inventory_Global.agregar_compound(compound, cantidad);
	Inventory_Global.agregar_compound(compound2,cantidad);
	
	Inventory_Global.seleccion_cambiada.connect(actualizar_barra)
	actualizar_barra()

func actualizar_barra():
	
	for children in get_children():
		children.queue_free()
	
	for compound in Inventory_Global.Poderes:
		var nuevo_slot = SLOT_SCENE.instantiate()
		add_child(nuevo_slot)
		
		if compound != null:
			var cantidad = Inventory_Global.Compound[compound]
			nuevo_slot.set_datos(compound, cantidad)
		else :
			nuevo_slot.set_datos(compound, 0)
