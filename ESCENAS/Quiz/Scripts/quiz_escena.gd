extends Control
@export var quiz_Data: Array[QuizQuestions]
@export var color_YES: Color
@export var color_NO: Color
var index= 0
var yes: int
var buttons: Array[Button]
var success: int
var timer: int = 1800
@onready var question_text: Label = $Questions/PanelContainer/Label
@onready var libro_anim: AnimatedSprite2D = $AnimatedSprite2D

##Funcion principa
func _ready() -> void:
	$nPregunta.text = "1"
	$Timer.stop(); $TicTacMbappe.stop()
	libro_anim.stop()
	libro_anim.frame = 5
	##Preguntas bien respondidas 0
	success=0
	##Por cada boton en vBOX
	for b in $BoxContainer/Vbox_Respuestas.get_children():
		if b is Button:
			buttons.append(b)
	##Hacemos que las preguntas se mezclen para que no se repitan el orden
	quiz_Data.shuffle()
	load_quiz()

##Logica de carga
func load_quiz() -> void:
	libro_anim.stop()
	libro_anim.frame = 5
	if index > quiz_Data.size()-1:
		_over()
		return
	##Si no se termino, cargamos la informacion en pantalla dependiendo de los que tengamos en Resources o carpeta Questions
	question_text.text = quiz_Data[index].question_info
	for i in buttons.size():
		buttons[i].text = quiz_Data[index].question_option[i]
		buttons[i].pressed.connect(_button_click.bind(buttons[i]))
	$Questions.show(); $BoxContainer.show(); $Preguntas.show(); $Respuestas.show(); $nPregunta.show()

##Logica de Botones
func _button_click(button) -> void:
	for b in buttons:
		b.release_focus()
	##Por cada boton clikeado
	if quiz_Data[index].question_correct == button.text:
		button.modulate = color_YES
		$SuccesSFX.play()
		success=success+1
		##Respuesta correcta reproducimos exito cambiamos color y aumentamos
	else:
		button.modulate = color_NO
		$ErrorSFX.play()
		for b in buttons:
			if b.text == quiz_Data[index].question_correct:
				b.modulate = Color.GREEN
	##Anidamos otra funcion para carga de la siguiente pregunta
	next_question()

##Logica de siguiente pregunta
func next_question() -> void:
	await get_tree().create_timer(3).timeout
	##Desconectamos los botones 
	for b in buttons:
		b.pressed.disconnect(_button_click)
	$Questions.hide();$BoxContainer.hide();$Preguntas.hide();$Respuestas.hide(); $nPregunta.hide()
	libro_anim.frame = 0
	libro_anim.play("default")
	await libro_anim.animation_finished
	##Reseteamos color
	for b in buttons:
		b.modulate = Color.WHITE
	##Mandamos otro resource (siguiente pregunta)
	index=index+1
	$nPregunta.text = str(index+1)
	load_quiz()

##Pantalla Final
func _over() -> void:
	$ColorRect.show()
	$ColorRect/Score.text = str(success, "/", quiz_Data.size())
	$Timer.stop(); $TicTacMbappe.stop()

func _on_timer_timeout() -> void:
	if timer > 0:
		timer -= 1
		$TimerTxt.text = time_to_string(timer)
		$TicTacMbappe.play()
	else:
		$TicTacMbappe.stop(); $Timer.stop()
		_over()

func time_to_string(seconds: int) -> String:
	var minutes: int = seconds / 60
	var seconds2: int = seconds % 60
	return str(minutes) + ":" + str(seconds2).pad_zeros(2)
	
	

func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ESCENAS/Torre/Torre.tscn")

func _on_option_button_pressed() -> void:
	TutorialGeneral.mostrar("quiz")

func _on_exit_lab_pressed() -> void:
	get_tree().change_scene_to_file("res://ESCENAS/Torre/Torre.tscn")


func _on_continuar_pressed() -> void:
	$Inicio.hide(); $Timer.start(); $TicTacMbappe.play()

func _on_exit_ayuda_pressed() -> void:
	$Ayuda.hide()

func _on_ayuda_button_pressed() -> void:
	$Ayuda.show()
