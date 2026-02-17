extends Control
class_name PagCompound

@onready var grid = $MarginContainer/VScrollBar/GridContainer
@onready var slot = preload("res://ESCENAS/Hud_player/slot_compound.tscn")

func _ready() -> void:
	#esto es de prueba ya que el personaje tendria quec conseguirlos en el world
	var compound = load("res://ESCENAS/Compound/Resource/Compound_Aluminio.tres");
	var compound2 = load("res://ESCENAS/Compound/Resource/C_Calcio.tres");
	var cantidad = 2
	Inventory_Global.agregar_compound(compound, cantidad);
	Inventory_Global.agregar_compound(compound2,cantidad);
	
	create_grid_inventory()

func create_grid_inventory(): 
	
	#limpiamos para evitar duplicados
	for children in grid.get_children():
		children.queue_free()
		
	for compound in Inventory_Global.Compound:
		
		var cantidad = Inventory_Global.Compound[compound]
		var new_slot = slot.instantiate()
		grid.add_child(new_slot)
		new_slot.set_datos(compound, cantidad)
		
