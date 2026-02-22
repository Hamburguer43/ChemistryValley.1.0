extends Area2D
class_name HealthComponent

##este componente me controla la vida del body, si recibe dano o se cura etc
signal Ondead
signal OnBarhealthChange(values: int)
signal OnDirectionChange(value_position: Vector2, force: int)

@export_group("Values_Health")
@export var max_salud: int = 3
@export var current_salud: int = 0
var ability_comp

func _ready() -> void:
	current_salud = max_salud

func take_damage(damage: int, value_position: Vector2, force: int):
	
	ability_comp = get_parent().get_node_or_null("Ability_comp")
	
	if ability_comp and ability_comp.esta_protegido == true:
		return
	
	#Aplicar dano al body (restar)
	var value = abs(damage)
	health_controller(-value)
	
	#Emitimos signal para que el body la capte y ejecute el empuje
	OnDirectionChange.emit(value_position, force)

func health_controller(value: int):
	var old_health = current_salud
	current_salud += value
	current_salud = clamp(current_salud, 0, max_salud)
	
	if old_health != current_salud:
		#Emitimos la senal que está conectada en healt_bar y le pasamos el valor actual de la vida
		OnBarhealthChange.emit(current_salud)
	
	if current_salud <= 0:
		dead()

func dead():
	emit_signal("Ondead")
	get_parent().queue_free()
