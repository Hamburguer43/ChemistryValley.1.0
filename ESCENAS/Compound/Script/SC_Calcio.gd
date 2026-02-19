extends Compound_Res
class_name SC_Calcio

@export var vida: int = 1
@export var color: Color = Color.GREEN

func ejecutar_poder(_player: CharacterBody2D, ability_comp: Node):
	
	ability_comp.activar_regeneracion(vida, color)
