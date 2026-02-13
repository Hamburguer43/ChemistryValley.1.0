extends Node
class_name EnergyComponent

signal OnEnergyChanged(current_energy: int)

@export_group("Settings")
@export var max_energy: int = 100
@export var regen_speed: float = 10.0 # Energía por segundo
@export var regen_enabled: bool = true

@onready var current_energy: float = max_energy

func _process(delta: float) -> void:
	
	#Si la energia es utilizada en este caso hace un ataque, ejecuta if
	if regen_enabled and current_energy < max_energy:
		current_energy = move_toward(current_energy, max_energy, regen_speed * delta)
		
		OnEnergyChanged.emit(int(current_energy))

func consume_energy(amount: int):
	current_energy = clamp(current_energy - amount, 0, max_energy)
	OnEnergyChanged.emit(int(current_energy))
