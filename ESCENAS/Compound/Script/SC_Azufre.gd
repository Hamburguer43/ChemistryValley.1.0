extends Compound_Res
class_name SC_Azufre

@export var dano: int = 2
@export var fuerza: int = 200
@export var tiempo: float = 6.0
@export var color: Color = Color.DARK_GREEN

func ejecutar_poder(_player: CharacterBody2D, ability_comp: Node):
	
	ability_comp.activar_golpe_corrosivo(dano, fuerza, tiempo, color)
