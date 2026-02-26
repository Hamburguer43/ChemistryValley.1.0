extends Node
var Poderes: Array[Compound_Res] = [null, null, null, null]
var Elementos: Dictionary = {}
var Compound: Dictionary = {}

var slot_seleccionado: int = 0 : 
	set(value):
		slot_seleccionado = clamp(value, 0, 3)
		seleccion_cambiada.emit()
signal  seleccion_cambiada
signal slot_utilizado
signal actualizar_inventory

func agregar_element(elemento: Element_Res, cantidad: int):
	
	if Elementos.has(elemento):
		Elementos[elemento] += cantidad
	else:
		Elementos[elemento] = cantidad
	actualizar_inventory.emit()

func agregar_compound(compound: Compound_Res, cantidad: int = 1):
	
	if Compound.has(compound):
		Compound[compound] += cantidad
	else:
		Compound[compound] = cantidad 
	
	actualizar_inventory.emit()

func equipar_compuesto(res: Compound_Res, index: int):
	# Verificar si el compuesto ya está en algún otro slot
	var slot_existente = Poderes.find(res)
	# al buscar devuelve -1 si no encuentra ningun igual, pero si hay uno igual devuelve != -1
	print(slot_existente)
	
	if slot_existente != -1:
		Poderes[slot_existente] = null
		slot_utilizado.emit()
	
	#Si no está duplicado, procedemos a equiparlo
	Poderes[index] = res
	seleccion_cambiada.emit()

func get_poder_actual() -> Compound_Res:
	return Poderes[slot_seleccionado]
