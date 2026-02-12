extends TextureProgressBar

@onready var health_component : HealthComponent = $"../HealthComponent"

func _ready() -> void:
	
	#Inicializamos los valores de la barra al empezar
	max_value = health_component.max_salud
	value = health_component.current_salud
	
	checked_visibility_bar(value)
	
	#Conectamos la señal que creamos en healthComponent por código
	health_component.OnBarhealthChange.connect(update_bar_health)

func update_bar_health(nueva_salud: int) -> void:
	# Esta función se ejecuta CADA VEZ que el componente emite la señal
	value = nueva_salud
	checked_visibility_bar(value)

func checked_visibility_bar(value):
	if value >= max_value or value <= 0:
		hide()
	else:
		show()
