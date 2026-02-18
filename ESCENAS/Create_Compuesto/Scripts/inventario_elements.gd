extends Control
class_name inventario_elements

@onready var grid = $Book/MarginContainer/VScrollBar/GridContainer
@onready var slot = preload("res://ESCENAS/Create_Compuesto/slot_inventory.tscn")
@onready var animation: AnimationPlayer = $Book/AnimatedSprite2D
@onready var text = $Book/Text
var tween: Tween

signal take_element(element: Element_Res)

# -- animaciones de tween para el inventario -------
func _on_button_pressed() -> void:
	
	self.pivot_offset = size/2
	self.scale = Vector2.ZERO
	self.modulate.a = 0.0
	self.show()
	
	reset_tween()
	
	tween.parallel().tween_property(self, "scale", Vector2.ONE, 0.4).set_trans(Tween.TRANS_BACK)
	tween.parallel().tween_property(self, "modulate:a", 1.0, 0.2)
	
	animation.play("open")
	
func reset_tween():
	if tween:
		tween.kill()
	tween = create_tween()

#Boton de cerra libro/ inventario
func _on_texture_button_pressed() -> void:
	reset_tween()
	
	for children in grid.get_children():
		children.queue_free()
		$Book/Label.visible = false
	
	animation.play("close")
	await animation.animation_finished
	
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.parallel().tween_property(self, "scale", Vector2.ZERO, 0.4)
	tween.parallel().tween_property(self, "modulate:a", 0.0, 0.2)
	

func close_nodo():
	self.hide()

# -----------------------------------------------------

func _ready() -> void:
	#esto es de prueba ya que el personaje tendria quec conseguirlos en el world
	
	var hierro = load("res://ESCENAS/Elements/Resource/Metales/Hierro.tres")
	var oro = load("res://ESCENAS/Elements/Resource/Metales/Oro.tres")
	var cantidad = 1
	Inventory_Global.agregar_element(hierro, cantidad)
	Inventory_Global.agregar_element(oro, cantidad)
	
	create_grid_inventory()

func create_grid_inventory(): 
	
	#Comprobamos de que hay elementos en el inventario, si no muestra un mensaje
	if Inventory_Global.Elementos.size() == 0:
		text.visible = true
	else :
		text.visible = false
	
	#limpiamos para evitar duplicados
	for children in grid.get_children():
		children.queue_free()
		
	for elemento in Inventory_Global.Elementos:
		var new_slot = slot.instantiate()
		grid.add_child(new_slot)
		new_slot.set_datos(elemento)
		
		new_slot.pressed.connect(elemento_elegido.bind(elemento))

func elemento_elegido(elemento: Element_Res):
	
	if elemento != null:
		take_element.emit(elemento)
	
	_on_texture_button_pressed()

func _on_animated_sprite_2d_animation_finished(anim_name: StringName) -> void:
	if anim_name == "open":
		create_grid_inventory()
	
	if anim_name == "close":
		close_nodo()
