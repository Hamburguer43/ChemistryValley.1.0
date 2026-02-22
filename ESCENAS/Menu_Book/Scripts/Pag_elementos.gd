extends Control
class_name PagElement

@onready var grid = $MarginContainer/VScrollBar/GridContainer
@onready var slot = preload("res://ESCENAS/Create_Compuesto/slot_inventory.tscn")

func _ready() -> void:
	Inventory_Global.actualizar_inventory.connect(create_grid_inventory)
	create_grid_inventory()

func create_grid_inventory(): 
	
	#limpiamos para evitar duplicados
	for children in grid.get_children():
		children.queue_free()
		
	for elemento in Inventory_Global.Elementos:
		
		var cantidad = Inventory_Global.Elementos[elemento]
		var new_slot = slot.instantiate()
		grid.add_child(new_slot)
		new_slot.set_datos(elemento, cantidad)
		
