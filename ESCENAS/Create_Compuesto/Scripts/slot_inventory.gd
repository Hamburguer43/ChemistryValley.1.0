extends TextureButton

var compound: Compound_Res
@onready var sprite: Sprite2D = $Sprite2D

func set_datos(res: Compound_Res):
	compound = res
	sprite.texture = res.textura
	tooltip_text = res.nombre # Para que al poner el mouse diga qué es
