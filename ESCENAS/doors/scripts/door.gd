extends Node2D

@export_group("Visuales")
@export var animaciones_especificas: SpriteFrames 

@export_group("Configuración")
@export_file("*.tscn") var escena_destino: String

@onready var anim_sprite = $AnimatedSprite2D
@onready var interactable = $Interaction

func _ready() -> void:
	
	if animaciones_especificas != null:
		anim_sprite.sprite_frames = animaciones_especificas
	else:
		print("Cuidado: No hay recurso en 'Animaciones Especificas' de ", name)
	
	interactable.activado.connect(_al_abrir_puerta)

func _al_abrir_puerta() -> void:
	
	if escena_destino == "": return
	
	# Desactivamos el área para evitar doble interacción
	interactable.set_deferred("monitoring", false)
	
	# REACCIÓN: Ejecutamos la animación de apertura
	if anim_sprite.sprite_frames.has_animation("open"):
		anim_sprite.play("open")
		$Audios/AudioStreamPlayer.play()
		await anim_sprite.animation_finished 
	
	get_tree().change_scene_to_file(escena_destino)


func _on_interaction_body_entered(body: Node2D) -> void:
	if body is Player:
		$Boton.visible = true


func _on_interaction_body_exited(body: Node2D) -> void:
	if body is Player:
		$Boton.visible = false
