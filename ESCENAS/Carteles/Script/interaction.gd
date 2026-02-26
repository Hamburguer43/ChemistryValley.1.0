extends Area2D
class_name Interactable

# La señal que emitirá al interactuar
signal activado

func interact() -> void:
	activado.emit()
