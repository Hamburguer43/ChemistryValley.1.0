extends Compound_Res
class_name SC_Cobre1

@export var boost_velocidad: float = 80 # Multiplicador de velocidad
@export var tiempo: float = 4.0        # Cuánto dura el efecto
@export var color_cobre: Color = Color.ORANGE_RED

func ejecutar_poder(player: CharacterBody2D, ability_comp: Node):
	# Le pedimos al componente que aplique velocidad
	ability_comp.activar_velocidad(boost_velocidad, tiempo, color_cobre)
