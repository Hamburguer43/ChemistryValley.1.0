extends CharacterBody2D
class_name Enemy

@onready var movement : Movement = $"Movement" as Movement
@onready var sprite = $Direction/Sprite2D/AnimatedSprite2D
@onready var Direction = $Direction
@onready var rayCast: RayCast2D = $"RayCast2D"
@onready var sensor: Area2D = $"SensorComponent"
@onready var health_component : HealthComponent = $HealthComponent
@onready var hitbox_component: HitboxComponent = $Direction/HitbosComponent
@onready var statemachine: StateMachine = $StateMachine
@onready var loot_component: Loot_component = $LootComponent

@export_group("Visual Skin")
@export var skin_variante : SpriteFrames 
@export var offset_visual : Vector2 = Vector2.ZERO # Para mover el sprite arriba/abajo
@export var escala_visual : Vector2 = Vector2(1, 1) # Por si un enemigo es más grande

@export_group("Collision Adjustment")
@export var collision_radius : float = 10.0 # Ajustar el ancho de colisión
@export var collision_height : float = 20.0 # Ajustar el alto

var direction = 1.0
var player: CollisionObject2D
var is_stunned: bool = false
var position_hit: Vector2
var force_hit: int = 0

func _process(_delta: float) -> void:
	
	if is_stunned == true:
		return
	
	fase_sprite()
	
func _ready() -> void:
	
	if skin_variante:
		sprite.sprite_frames = skin_variante
	
	# Ajustamos la posición del sprite por si el dibujo es más alto/bajo
	sprite.position = offset_visual
	Direction.scale = escala_visual
	
	# Ajustamos la colisión dinámicamente (si usas un CapsuleShape2D)
	var shape = $CollisionShape2D.shape
	if shape is CapsuleShape2D:
		shape.radius = collision_radius
		shape.height = collision_height

	health_component.OnDirectionChange.connect(direction_change_body)
	hitbox_component.set_hitbox_active(true)
	health_component.Ondead.connect(logic_botin)
	
#Modifica el valor hacia donde este mirando el Sprite2d
func fase_sprite():
	
	if not is_instance_valid(Direction): 
		return
	
	if velocity.x < 0:
		Direction.scale.x = 1
	elif velocity.x > 0:
		Direction.scale.x = -1

#Senal que verifica que si el cuerpo que entro es un CollisionObject2d (PLayer)
func _on_sensor_component_body_entered(body: Node2D) -> void:
	player = body

#Senal que verifica que si el cuerpo que salió es un CollisionObject2d (PLayer)
func _on_sensor_component_body_exited(_body: Node2D) -> void:
	player = null

#metodo que se ejecuta cuando emite la signal y cambia la direcion del body cuando recibe dano
func direction_change_body(value_position, force):
	
	position_hit = value_position
	force_hit = force
	
	statemachine.change_state("HitState")

func logic_botin():
	
	var puntos_enemigo = 0
	# Sumamos los puntos actuales + los nuevos
	var nuevo_total = BdGlobal.game_data.high_score + puntos_enemigo
	
	BdGlobal.actualizar_puntaje(nuevo_total)
	
	if  is_instance_valid(loot_component):
		loot_component.soltar_botin()
		print("se instanció")
	
	await get_tree().create_timer(0.1).timeout
	
	queue_free()
