extends Node

var music_player: AudioStreamPlayer

func _ready():
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	music_player.stream = load("res://ASSETS/Audios/Musica/magic-in-the-air-43177.mp3") 
	music_player.volume_db = -15.0
	music_player.process_mode = Node.PROCESS_MODE_ALWAYS 

func play_lobby_music():
	if not music_player.playing:
		music_player.play()

func stop_lobby_music():
	if music_player.playing:
		music_player.stop()
