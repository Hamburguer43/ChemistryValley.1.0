extends Node2D

@onready var bird_audio: AudioStreamPlayer = $Audios/Bird

func _ready() -> void:
	bird_audio.play()
