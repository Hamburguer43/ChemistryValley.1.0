extends Node

var music_player: AudioStreamPlayer
var musicTorre = {
	"lobby": "res://ASSETS/Audios/Musica/magic-in-the-air-43177.mp3",
	"lobby2": "res://ASSETS/Audios/Musica/your-dreams-come-true-magical-fantasy-cinematic-intro-206418.mp3"
}
var actMusic = ""
func _ready():
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	music_player.volume_db = -15.0
	music_player.process_mode = Node.PROCESS_MODE_ALWAYS 
	music_player.finished.connect(music_finished)


func play_music(music: String):
	if not musicTorre.has(music):
		return
	if actMusic == music:
		return
	actMusic = music
	music_player.stream = load(musicTorre[music])
	music_player.play()

func stop_music():
	music_player.stop()
	actMusic = ""

func music_finished():
	if actMusic == "lobby":
		play_music("lobby2")
	else:
		play_music("lobby")
