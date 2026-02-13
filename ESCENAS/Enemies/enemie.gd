extends CharacterBody2D
class_name Enemy

@onready var movement : Movement = $"Movement" as Movement
@onready var sprite = $Sprite2D/AnimatedSprite2D
@onready var rayCast: RayCast2D = $"RayCast2D"
@onready var sensor: Area2D = $"SensorComponent"
@onready var health_component : HealthComponent = $HealthComponent
@onready var hitbox_component: HitboxComponent = $HitbosComponent

var direction = 1.0
var player: CollisionObject2D
var is_stunned: bool = false

func  _physics_process(delta: float) -> void:
	
	if is_stunned:    
		move_and_slide()
		return
	
	#Si player contiene un body (player) ejecuta la función follow_player, en caso contrario sigue con su ruta normal
	if player != null:
		follow_player(delta)
	else:
		_patrol(delta)

func _process(delta: float) -> void:
	fase_sprite()
	
func _ready() -> void:
	health_component.OnDirectionChange.connect(direction_change_body)
	hitbox_component.set_hitbox_active(true)

#Modifica el valor hacia donde este mirando el Sprite2d
func fase_sprite():
	
	if velocity.x > 0:
		sprite.flip_h = true
	elif velocity.x < 0:
		sprite.flip_h = false

#Funcion que modifica la direccion hacia donde este el player 
func follow_player(delta):
	
	
	var directionPlayer = sign(player.global_position.x - global_position.x)
	var distance = global_position.distance_to(player.global_position)
	
	if distance > 20: 
		movement.handle_movement(self, directionPlayer, delta)
	
	direction = directionPlayer

#funcion que calcula el movimiento de patrulla del enemie
func _patrol(delta: float) -> void:
	
	#Verifica que el raycast no este colisionando con algo
	var not_is_in_floor = not rayCast.is_colliding()
	
	#Si el body choca con una pared o el raycast ya no colisiona con algo(no hay suelo) cambia la dirección
	if is_on_wall() or not_is_in_floor:
		direction *= -1.0
		rayCast.position.x *= -1
	
	movement.handle_movement(self, direction, delta)

#Senal que verifica que si el cuerpo que entro es un CollisionObject2d (PLayer)
func _on_sensor_component_body_entered(body: Node2D) -> void:
	player = body

#Senal que verifica que si el cuerpo que salió es un CollisionObject2d (PLayer)
func _on_sensor_component_body_exited(body: Node2D) -> void:
	player = null

#metodo que se ejecuta cuando emite la signal y cambia la direcion del body cuando recibe dano
func direction_change_body(value_position, force):
	
	is_stunned = true
	#calcula el la position global del enemie - la posicion del player
	var Empujon = (global_position - value_position).normalized()
	
	velocity = Empujon * force
	velocity.y -= 100 
	# Timer 
	await get_tree().create_timer(0.2).timeout
	is_stunned = false
