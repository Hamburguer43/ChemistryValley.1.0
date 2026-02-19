extends TextureProgressBar

var health_node : HealthComponent 

func setup_health(node: HealthComponent) -> void:
	
	health_node = node
	
	# Configuramos valores iniciales
	max_value = health_node.max_salud
	value = health_node.current_salud
	print(value)
	
	health_node.OnBarhealthChange.connect(update_bar_health)
	
	checked_visibility_bar(value)

func update_bar_health(nueva_salud: int) -> void:
	# Animación fluida con Tween
	var tween = create_tween()
	tween.tween_property(self, "value", nueva_salud, 0.3).set_trans(Tween.TRANS_SINE)
	checked_visibility_bar(nueva_salud)

func checked_visibility_bar(_nueva_salud):
		show()
