extends Compound_Res
class_name SC_Hierro1

@export var duracion_escudo: float = 5
@export var color_darkblue: Color = Color.BLUE

func ejecutar_poder(_player: CharacterBody2D, ability_comp: Node):
	# El script le da la orden al componente ability_comp de ejecutar la función correspondiente
	ability_comp.activar_invulnerabilidad(duracion_escudo, color_darkblue)
