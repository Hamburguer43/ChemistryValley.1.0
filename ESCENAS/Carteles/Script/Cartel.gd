extends Node2D

@export var datos: Cartelito_Res

func _ready() -> void:
	# Lógica visual del cartel
	if datos:
		$Aviso/Titulo.text = datos.title
		$Aviso/Cotenido.text = datos.content
	
	# CONEXIÓN: Escuchamos al componente interactuable
	$Interaction.activado.connect(al_interactuar)

func al_interactuar() -> void:
	# Lo que sucede al presionar E
	$Aviso.visible = !$Aviso.visible
	$Audios/AudioStreamPlayer.play()
	

func _on_interaction_body_exited(body: Node2D) -> void:
	if body is Player:
		await get_tree().create_timer(0.2).timeout 
		$Aviso.visible = false
		$Boton.visible = false

func _on_interaction_body_entered(body: Node2D) -> void:
	
	if body is Player:
		$Boton.visible = true
