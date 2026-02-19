extends Compound_Res

@export var boost_fuerza: float = 250.0
@export var tiempo: float = 6.0
@export var color: Color = Color.AQUAMARINE

func ejecutar_poder(_player: CharacterBody2D, ability_comp: Node):
	
	ability_comp.activar_super_salto(boost_fuerza, tiempo, color)
