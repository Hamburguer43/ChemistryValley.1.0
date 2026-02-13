extends CharacterBody2D
class_name Player

@onready var movement : Movement = $"Movement" as Movement
@onready var jump: Jump = $"Jump" as Jump
@onready var sprite: Sprite2D = $Direction/Sprite2D
@onready var animation: AnimationPlayer = $Direction/AnimationPlayer
@onready var health_component = $HealthComponent
@onready var health_bar = $HUD/Control/MarginContainer/Barra_Interfaz/Sprite2D/HealthBar
@onready var energy_bar = $HUD/Control/MarginContainer/Barra_Interfaz/Sprite2D/EnergyBar
@onready var hitbox_component = $Direction/HitboxComponent
@onready var energy_component = $EnergyComponent
@onready var Direction = $Direction

func _ready() -> void:
	health_bar.setup_health(health_component)
	energy_bar.setup_energy(energy_component)

func _process(_delta: float) -> void:
	fase_sprite()

func fase_sprite():
	
	if not is_instance_valid(Direction): 
		return
	
	if velocity.x < 0:
		Direction.scale.x = -1
	elif velocity.x > 0:
		Direction.scale.x = 1
