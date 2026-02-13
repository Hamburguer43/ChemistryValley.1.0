extends TextureProgressBar

func setup_energy(node: EnergyComponent) -> void:
	
	max_value = node.max_energy
	value = node.current_energy
	# Conectamos la señal del componente a la función de actualización
	node.OnEnergyChanged.connect(update_bar)

func update_bar(new_value: int) -> void:
	var tween = create_tween()
	tween.tween_property(self, "value", new_value, 0.2).set_trans(Tween.TRANS_SINE)
