extends Node

var pistas = {
	"magic_in_the_air": preload("res://ASSETS/Audios/Musica/magic-in-the-air-43177.mp3"),
	"faded_rose_dark": preload("res://ASSETS/Audios/Musica/the-faded-rose-dark-fantasy-background-music-109375_nNYwL6wv.mp3"),
}

@onready var audio = $AudioStreamPlayer2D

func _ready() -> void:
	
	if audio == null:
		return
	
	# Conectamos la señal 'finished' a una función propia
	audio.finished.connect(_on_musica_terminada)

func _on_musica_terminada():
	# Aquí decidimos qué pasa al terminar
	cambiar_musica("faded_rose_dark")

func cambiar_musica(nombre_pista: String):
	
	if audio == null:
		return
	
	if pistas.has(nombre_pista):
		audio.stream = pistas[nombre_pista]
		audio.play()
