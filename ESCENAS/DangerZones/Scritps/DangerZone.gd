extends Node2D

@export var datos: DangerZone_Res
#intente hacerlo dinamico y me salio mal, mala leche
@onready var visual: AnimatedSprite2D = $Visual
@onready var hitbox: HitboxComponent = $HitboxComponent


func _ready():
	# Daño
	hitbox.damage = datos.daño
	hitbox.set_hitbox_active(true)
	# Animacion
	if datos.frames:
		visual.sprite_frames = datos.frames
		visual.play(datos.anim_name)
