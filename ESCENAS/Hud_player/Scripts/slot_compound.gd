extends TextureButton
class_name Slot_compound

var compound: Compound_Res
@onready var sprite: Sprite2D = $Sprite2D

func set_datos(res: Compound_Res, cantidad):
	
	compound = res
	
	if compound != null:
		# Si hay un poder, mostramos su icono y nombre
		sprite.texture = res.textura
		sprite.visible = true
		tooltip_text = res.nombre
		$Label.text = str(cantidad)
	else:
		# Si es null, limpiamos el slot visualmente
		sprite.texture = null
		sprite.visible = false
		tooltip_text = "Espacio vacío"

# --- LÓGICA DE DRAG AND DROP ---

# 1. Al empezar a arrastrar (Desde el Inventario)
func _get_drag_data(_at_position):
	
	if compound == null: return null
	
	# Creamos la vista previa (el icono que sigue al mouse)
	var preview = TextureRect.new()
	preview.texture = sprite.texture
	preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview.custom_minimum_size = Vector2(60, 60)
	set_drag_preview(preview)
	
	return compound # Enviamos el recurso

# 2. ¿Se puede soltar aquí? (Para los Slots de Poderes)
func _can_drop_data(_at_position, data):
	# Solo aceptamos si lo que arrastramos es un Compound_Res
	return data is Compound_Res
	
	if Inventory_Global.Poderes.has(data):
		return false

# 3. Al soltar el compuesto (En el Slot Activo)
func _drop_data(_at_position, data):
	var index = get_index() 
	Inventory_Global.equipar_compuesto(data, index)
