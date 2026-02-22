extends CanvasLayer
class_name Card_compound

var formula_correcta: bool = false
var nombre_correcto: bool = false
@onready var nodo_compound = $"CenterContainer/Compound-info"
@onready var nodo_reto = $CenterContainer/Reto
@onready var Aviso_error = $CenterContainer/Aviso_error

# -- Nodo Compound-info -------------------------------------------------------
@onready var compound = $"CenterContainer/Compound-info/Marco_compound/Compound"
@onready var LabelNombre = $"CenterContainer/Compound-info/VBoxContainer/LabelNombre"
@onready var LabelFormula = $"CenterContainer/Compound-info/VBoxContainer/LabelFormula"
@onready var LabelRareza = $"CenterContainer/Compound-info/VBoxContainer/LabelRareza"
@onready var Description = $"CenterContainer/Compound-info/Description"
@onready var Description2 = $"CenterContainer/Compound-info/Description2"

# -- Nodo Reto -----------------------------------------------------------------------
	# -- Formulas --------------------------------------------------------------------
@onready var label_pregunta = $CenterContainer/Reto/Contenedor/Formulas/LabelPregunta
@onready var contenedor_botones = $CenterContainer/Reto/Contenedor/Formulas/Opciones

	# -- Nomenclatura ----------------------------------------------------------------
@onready var input_nombre = $CenterContainer/Reto/Contenedor/Nomenclatura/Nombre

var compound_actual = Compound_Res
var elemento = Element_Res
signal guardar_compound(compound: Compound_Res)

func show_card_compound(compound_res, elemento_res):
	
	compound_actual = compound_res
	elemento = elemento_res
	mostrar_compound_info(compound_res)
	
	nodo_compound.visible = false
	nodo_reto.visible = true
	
	configurar_hoja_reto()
	
# -- Card Reto ---------------------------------------------------
func configurar_hoja_reto():
	# Configurar botones de fórmulas
	var opciones = [compound_actual.formula]
	opciones.append_array(compound_actual.formulas)
	opciones.shuffle()
	
	for opt in opciones:
		var btn = Button.new()
		btn.text = opt
		contenedor_botones.add_child(btn)
		btn.pressed.connect(verificar_formula.bind(opt, btn))

func verificar_formula(seleccion: String, boton_presionado: Button):
	if seleccion == compound_actual.formula:
		formula_correcta = true
		boton_presionado.modulate = Color.GREEN
		comprobacion_final()
	else:
		boton_presionado.modulate = Color.RED
		# Solo mostramos el tutorial del cruce de valencias
		mostrar_tutorial_formula()

func _on_nombre_text_submitted(new_text: String) -> void:
	var respuesta = new_text.to_lower().strip_edges()
	var correcta = compound_actual.nombre.to_lower().strip_edges()
	
	if respuesta == correcta:
		nombre_correcto = true
		input_nombre.modulate = Color.GREEN
		comprobacion_final()
	else:
		input_nombre.modulate = Color.RED
		# Solo mostramos el tutorial de nomenclatura (Oso/Ico)
		mostrar_tutorial_nomenclatura()

func comprobacion_final():
	
	if formula_correcta and nombre_correcto:
		
		print("Si")
		await get_tree().create_timer(0.5).timeout
		nodo_compound.visible = true
		nodo_reto.visible = false
		mostrar_compound_info(compound_actual)

# -- Card Compound info -------------------------------------------
func mostrar_compound_info(compound_res):
	compound.texture = compound_res.textura
	LabelNombre.text = compound_res.nombre
	LabelFormula.text = compound_res.formula
	LabelRareza.text = compound_res.rareza
	Description.text = compound_res.descripcion
	Description2.text = compound_res.poder_descripcion
	
	match compound_res.rareza:
		"Comun":
			LabelNombre.add_theme_color_override("font_color", Color.WEB_GREEN)
		"Raro":
			LabelNombre.add_theme_color_override("font_color", Color.DODGER_BLUE)
		"Epico":
			LabelNombre.add_theme_color_override("font_color", Color.REBECCA_PURPLE)
		"Peligroso":
			LabelNombre.add_theme_color_override("font_color", Color.ORANGE_RED)

# -- Guardar o cancelar -----------------------------------------
func _on_guardar_pressed() -> void:
	
	if compound_actual:
		print("emitir signal")
		guardar_compound.emit(compound_actual)
		queue_free()

func _on_cancelar_pressed() -> void:
	queue_free()

# -- funciones extras -------------------------------------------
# --- TUTORIAL PARA LA FORMULA (Botones) ---
func mostrar_tutorial_formula():
	var txt = "--- REGLA DEL CRUCE ---\n\n"
	txt += "1. El " + elemento.nombre + " le da su valencia al Oxigeno.\n"
	txt += "2. El Oxigeno siempre le da un 2 al " + elemento.nombre + ".\n\n"
	txt += "DATO: Si ambos numeros son pares (ej: 2 y 2), la alquimia los simplifica a 1 y 1."
	
	mostrar_aviso_error(txt)

# --- TUTORIAL PARA EL NOMBRE (Escritura) ---
func mostrar_tutorial_nomenclatura():
	var tipo = "OXIDO" if elemento.tipo == "Metal" else "ANHIDRIDO"
	
	var txt = "--- REGLA DE NOMENCLATURA ---\n\n"
	txt += "TIPO: Como es un " + elemento.tipo + ", usa la palabra " + tipo + ".\n\n"
	txt += "SUFIJOS:\n"
	txt += "- Si usas la valencia MENOR: termina en OSO.\n"
	txt += "- Si usas la valencia MAYOR: termina en ICO.\n\n"
	txt += "Ejemplo: Hierro(2) = Ferroso | Hierro(3) = Ferrico."
	
	mostrar_aviso_error(txt)

func mostrar_aviso_error(mensaje: String):
	Aviso_error.get_node("ColorRect/Label").text = mensaje
	Aviso_error.visible = true
	var t = create_tween()
	t.tween_interval(10)
	t.tween_callback(func(): Aviso_error.visible = false)
