extends CharacterBody2D
class_name Player

@onready var movement : Movement = $"Movement" as Movement
@onready var jump: Jump = $"Jump" as Jump
@onready var sprite: Sprite2D = $"Sprite2D"
@onready var animation: AnimationPlayer = $"AnimationPlayer"


func _process(_delta: float) -> void:
	fase_sprite()

func fase_sprite():
	
	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false
