extends TextureButton

var metal: Element_Res
@onready var sprite: Sprite2D = $Sprite2D

func set_datos(res: Element_Res, cantidad):
	metal = res
	sprite.texture = res.icono
	tooltip_text = res.nombre # Para que al poner el mouse diga qué es
	$Label.text = str(cantidad)
