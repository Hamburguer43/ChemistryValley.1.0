extends Area2D
class_name HitboxComponent

#Este componente me controla el dano que hace el body a otros bodys

#dano por defecto
@export_group("Values_damage")
@export var damage: int = 1

#Por si se quiere agregar items que hagan mas dano
@export_group("Values_damage_items")

#EMpuje/Fuerza de las armas
@export_group("Values_force")
@export var force: int = 300

func _ready() -> void:
	#comprueba si un area entra en el area y ejecuta una funcion
	area_entered.connect(hit_damage)

func hit_damage(area):
	
	if area is HealthComponent:
		area.take_damage(damage, global_position, force)
