extends HBoxContainer

const SLOT_SCENE = preload("res://ESCENAS/Hud_player/slot_compound.tscn")

func _ready():
	
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
