extends Control
class_name Torre


func _ready() -> void:
	AudioManager_Global.play_music("lobby")


func _on_button_salir_pressed() -> void:
	AudioManager_Global.stop_music()
	get_tree().change_scene_to_file("res://ESCENAS/Level/Main_1/Main.tscn")

func _on_button_tabla_pressed() -> void:
	get_tree().change_scene_to_file("res://ESCENAS/Table_periodic/tabla_periodica.tscn")

func _on_button_compound_pressed() -> void:
	get_tree().change_scene_to_file("res://ESCENAS/Create_Compuesto/table_create_compound.tscn")

func _on_tutorial_button_pressed() -> void:
	TutorialGeneral.mostrar("laboratorio")

func _on_button_quiz_pressed() -> void:
	AudioManager_Global.stop_music()
	get_tree().change_scene_to_file("res://ESCENAS/Quiz/QuizEscena.tscn")
