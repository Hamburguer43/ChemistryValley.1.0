extends Node

var Elementos: Dictionary = {}
var Compound: Dictionary = {}

func agregar_element(elemento: Element_Res, cantidad: int):
	
	if Elementos.has(elemento):
		Elementos[elemento] += cantidad
	else:
		Elementos[elemento] = cantidad

func agregar_compound(compound: Compound_Res, cantidad: int = 1):
	
	if Compound.has(compound):
		Compound[compound] += cantidad
	else:
		Compound[compound] = cantidad 
	
