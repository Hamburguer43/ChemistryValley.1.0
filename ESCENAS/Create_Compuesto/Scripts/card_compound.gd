extends CanvasLayer
class_name Card_compound

@onready var compound = $CenterContainer/Control/Marco_compound/Compound
@onready var LabelNombre = $CenterContainer/Control/VBoxContainer/LabelNombre
@onready var LabelFormula = $CenterContainer/Control/VBoxContainer/LabelFormula
@onready var LabelRareza = $CenterContainer/Control/VBoxContainer/LabelRareza
@onready var Description = $CenterContainer/Control/Description
@onready var Description2 = $CenterContainer/Control/Description2
@onready var boton = $CenterContainer/Control/Guardar

var compound_actual = Compound_Res
signal guardar_compound(compound: Compound_Res)

func show_card_compound(compound_res):
	
	compound_actual = compound_res
	
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

func _on_guardar_pressed() -> void:
	
	if compound_actual:
		print("emitir signal")
		guardar_compound.emit(compound_actual)
		queue_free()


func _on_cancelar_pressed() -> void:
	queue_free()
