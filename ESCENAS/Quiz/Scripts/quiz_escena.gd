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

##Funcion principa
func _ready() -> void:
	##Preguntas bien respondidas 0
	success=0
	##Por cada boton en Hbox
	for b in $BoxContainer/HBox_Respustas.get_children():
		if b is Button:
			buttons.append(b)
	##Hacemos que las preguntas se mezclen para que no se repitan el orden
	quiz_Data.shuffle()
	##Cargamos Quiz
	load_quiz()

##Logica de carga
func load_quiz() -> void:
	##Se comprueba primero si el quiz ya termino
	
	if index > quiz_Data.size()-1:
		_over()
		return
	##Si no se termino, cargamos la informacion en pantalla dependiendo de los que tengamos en Resources o carpeta Questions
	question_text.text = quiz_Data[index].question_info
	for i in buttons.size():
		buttons[i].text = quiz_Data[index].question_option[i]
		buttons[i].pressed.connect(_button_click.bind(buttons[i]))

##Logica de Botones
func _button_click(button) -> void:
	button.release_focus()
	##Por cada boton clikeado, comprobamos el resource de la respuesta correcta con el texto del boton
	if quiz_Data[index].question_correct == button.text:
		button.modulate = color_YES
		$SuccesSFX.play()
		success=success+1
		##Respuesta correcta reproducimos exito cambiamos color y aumentamos
	else:
		button.modulate = color_NO
		$ErrorSFX.play()
	##Anidamos otra funcion para carga de la siguiente pregunta
	next_question()

##Logica de siguiente pregunta
func next_question() -> void:
	##Desconectamos los botones anteriores para que no se encuentre con problemas
	for b in buttons:
		b.pressed.disconnect(_button_click)
	##Espera de 3 segundos para cargar la siguiente
	await get_tree().create_timer(3).timeout
	##Reseteamos color
	for b in buttons:
		b.modulate = Color.WHITE
	##Mandamos otro resource (siguiente pregunta) y volvemos a cargar el quiz
	index=index+1
	load_quiz()

##Pantalla Final
func _over() -> void:
	$ColorRect.show()
	$ColorRect/Score.text = str(success, "/", quiz_Data.size())
	$Timer.stop()

func _on_timer_timeout() -> void:
	if timer > 0:
		timer -= 1
		$TimerTxt.text = time_to_string(timer)
	else:
		$Timer.stop()
		_over()

func time_to_string(seconds: int) -> String:
	var minutes: int = seconds / 60
	var seconds2: int = seconds % 60
	return str(minutes) + ":" + str(seconds2).pad_zeros(2)
	
	
func _on_exit_pressed() -> void:
	pass ##cambio de escena


func _on_exit_button_pressed() -> void:
	pass # Cambio de Escena
