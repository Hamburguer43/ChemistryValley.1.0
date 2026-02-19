extends Control
class_name PagElement

@onready var grid = $MarginContainer/VScrollBar/GridContainer
@onready var slot = preload("res://ESCENAS/Create_Compuesto/slot_inventory.tscn")

func _ready() -> void:
	#esto es de prueba ya que el personaje tendria quec conseguirlos en el world
	#var hierro = load("res://ESCENAS/Elements/Resource/Metales/Hierro.tres")
	#var oro = load("res://ESCENAS/Elements/Resource/Metales/Oro.tres")
	#var cobre = load("res://ESCENAS/Elements/Resource/Metales/Cobre.tres")
	#var oxigeno = load("res://ESCENAS/Elements/Resource/NoMetales/Oxigeno.tres")
	#var aluminio = load("res://ESCENAS/Elements/Resource/Metales/Aluminio.tres")
	#var titanio = load("res://ESCENAS/Elements/Resource/Metales/Titanio.tres")
	#var cantidad = 1
	#Inventory_Global.agregar_element(hierro, cantidad)
	#Inventory_Global.agregar_element(oro, cantidad)
	#Inventory_Global.agregar_element(cobre, cantidad)
	#Inventory_Global.agregar_element(oxigeno, cantidad)
	#Inventory_Global.agregar_element(aluminio, cantidad)
	#Inventory_Global.agregar_element(titanio, cantidad)
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
		
