extends Sprite2D
class_name Element
@export var resource: Element_Res
@export var cantidad: int = 1

@onready var hitbox = $Hitbox
@onready var coin: AudioStreamPlayer = $Audio

func _ready() -> void:
	texture = resource.icono
	
	hitbox.audio.connect(sonido)

func sonido():
	coin.play()
