extends Node2D

@onready var loot_component: Loot_Botin = $LootComponent
@onready var anim: AnimatedSprite2D = $Sprite/AnimatedSprite2D

var esta_abierto: bool = false

func _ready() -> void:
	
	$Interaction.activado.connect(open_chest)

func open_chest():
	
	print("abriendo")
	
	esta_abierto = true
	$Interaction.set_deferred("monitoring", false) # Desactivamos la zona de interacción
	$Boton.visible = false
	anim.play("default")
	await anim.animation_finished 
	$Audios/Open.play()
	
	if is_instance_valid(loot_component):
		loot_component.soltar_botin()

func _on_interaction_body_entered(body: Node2D) -> void:
	if body is Player and not esta_abierto:
		$Boton.visible = true

func _on_interaction_body_exited(body: Node2D) -> void:
	if body is Player:
		$Boton.visible = false
