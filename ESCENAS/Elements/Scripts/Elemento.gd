extends Sprite2D
class_name Element
@export var resource: Element_Res
@export var cantidad: int = 1

@onready var hitbox = $Hitbox
@export var coin: AudioStreamPlayer

func _ready() -> void:
	texture = resource.icono
	
	#cuando un player entra en el area del elemento, emite la signal y ejecuta la funcion de sonido
	hitbox.audio.connect(sonido)

func sonido():
	if coin:
		# Desactivamos la colisión y ocultamos el sprite para que parezca que se recogió
		hitbox.set_deferred("monitoring", false) 
		self.hide() 
		coin.play()
		await coin.finished
		queue_free()
