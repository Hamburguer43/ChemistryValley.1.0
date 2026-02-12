extends CanvasLayer

#Variables de cambio de texto, sonido, la animacion (Escribir), el arreglo de tutorial 
@onready var textoExplicacion = $Panel/Chat1/Label
@onready var sfx = $SFX
var escribir = Tween
var ind = 0
var tutorialAct = []

func _ready() -> void:
	self.hide()

#segun sea la escena, recibe un string que identifica que diccionario usar
func mostrar(mensaje : String):
	if mensaje == "tabla":
		tutorialAct = [
			{"texto": "Esta es la Tabla Periódica. Haz clic en un elemento para ver sus propiedades."},
			{"img": "res://RECURSOS/Sprites/Elements/Simbolo/azufre.png"}
		]
	if mensaje == "quiz":
		tutorialAct=[
			{"texto": "Las preguntas salen en el recuadro principal..."},
			{"img": "res"},
			{"texto": "Tienes 10 Minutos para responder, seleccionando alguna de las 4 respuestas"},
			{"img": "RES"},
			{"texto": "¡¡Buena Suerte!!"}
		]
	ind= 0
	self.show()
	get_tree().paused = true
	actualizar()

#cambio de texto o imagen si se desea en el tutorial
func actualizar():
	var data = tutorialAct[ind]
	textoExplicacion.text = data.get("texto","")
	textoExplicacion.visible_ratio = 0.0
	if data.has("img"):
		$Panel/Chat1.visible = false
		$Panel/Cambio.visible = true
		$Panel/Cambio.texture = load(data["img"])
	else:
		$Panel/Chat1.visible = true
		$Panel/Cambio.visible = false
	#creamos la animacion
	escribir=create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	escribir.tween_property(textoExplicacion, "visible_ratio", 1.0, 5).set_trans(Tween.TRANS_LINEAR)
	#aplicamos el efento segun los segundos que tome el escribir, predefinido por 5
	for i in range(50):
		escribir.parallel().tween_callback(sfx_escribir).set_delay(i * 0.1)

#sonido de escritura
func sfx_escribir():
	if $Panel/Chat1.visible and textoExplicacion.visible_ratio < 1.0:
		sfx.play()

#funcion cerrar, o avanzar, depende del ind
func _on_cerrar_pressed():
	if textoExplicacion.visible_ratio < 1.0:
		if escribir: escribir.kill()
		textoExplicacion.visible_ratio = 1.0
		return
	ind = ind+1 
	if ind < tutorialAct.size():
		actualizar()
	else:
		textoExplicacion.visible = true
		get_tree().paused = false
		self.hide()
