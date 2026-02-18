extends Node

var pistas = {
	"magic_in_the_air": preload("res://ASSETS/Audios/Musica/magic-in-the-air-43177.mp3"),
	"faded_rose_dark": preload("res://ASSETS/Audios/Musica/the-faded-rose-dark-fantasy-background-music-109375_nNYwL6wv.mp3"),
	"bird": preload("res://ASSETS/Audios/Audio/bird-whistling-in-the-forest-215441.mp3")
}

@onready var audio = $AudioStreamPlayer2D

func _ready() -> void:
	
	if audio == null:
		return

func cambiar_musica(nombre_pista: String):
	
	if audio == null:
		return
	
	if pistas.has(nombre_pista):
		audio.stream = pistas[nombre_pista]
		audio.play()
