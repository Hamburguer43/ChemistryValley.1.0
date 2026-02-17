extends CharacterBody2D
class_name Player

@onready var movement : Movement = $"Movement" as Movement
@onready var jump: Jump = $"Jump" as Jump
@onready var health_component = $HealthComponent
@onready var health_bar = $HUD/Control/MarginContainer/Barra_Interfaz/Sprite2D/HealthBar
@onready var energy_bar = $HUD/Control/MarginContainer/Barra_Interfaz/Sprite2D/EnergyBar
@onready var hitbox_component = $Direction/HitboxComponent
@onready var energy_component = $EnergyComponent
@onready var Direction = $Direction
@onready var menu_book = $Menu_book
@onready var script_menu: Script_menu = $Menu_book/Menu_Book
@onready var ability_comp: AbilityComponent = $Ability_comp

@onready var sprite: Sprite2D = $Direction/Sprite2D
@onready var animation: AnimationPlayer = $Direction/AnimationPlayer

func _ready() -> void:
	health_bar.setup_health(health_component)
	energy_bar.setup_energy(energy_component)
	script_menu.close.connect(toggle_book)

func _process(_delta: float) -> void:
	fase_sprite()

func fase_sprite():
	
	if not is_instance_valid(Direction): 
		return
	
	if velocity.x < 0:
		Direction.scale.x = -1
	elif velocity.x > 0:
		Direction.scale.x = 1

func _input(event):
	# Usamos una acción configurada en el Input Map (ej: "abrir_inventario")
	if event.is_action_pressed("Menu_book"): 
		toggle_book()

func toggle_book():
	
	if menu_book.visible:
		# CERRAMOS EL LIBRO
		menu_book.hide()
		get_tree().paused = false # El mundo vuelve a moverse
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED # El mouse desaparece para jugar
	
	else:
		# ABRIMOS EL LIBRO
		menu_book.show()
		script_menu.open_book()
		get_tree().paused = true # Pausamos el mundo para que no nos maten mientras leemos
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE # El mouse aparece para el Drag and Drop
