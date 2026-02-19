extends Compound_Res
class_name SC_Cobre2

@export var boost_velocidad: float = 100 # Multiplicador de velocidad
@export var tiempo: float = 6.0        # Cuánto dura el efecto
@export var color_cobre: Color = Color.RED

func ejecutar_poder(_player: CharacterBody2D, ability_comp: Node):
	# Le pedimos al componente que aplique velocidad
	ability_comp.activar_velocidad(boost_velocidad, tiempo, color_cobre)
