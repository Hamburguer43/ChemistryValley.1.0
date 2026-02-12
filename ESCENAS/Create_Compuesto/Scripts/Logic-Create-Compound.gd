extends Node
class_name Logic_Create_Compound

func create_formula(metal: Element_Res, valencia: int):
	
	var oxigeno = 2
	var valencia_m = oxigeno
	var valencia_o = valencia
	
	# simplificamos las valencias. Si valencia_m = 2 y valencia_o = 2 seria 1 y 1
	# como return a entonces devolveria un valor, si a=2
	# entonces dividimos el valor de valencia_m / div, 2/2 = 1, si 4/2 = 1
	var div = divisor(valencia_m, valencia_o)
	valencia_m /= div
	valencia_o /= div
	
	# creamos la formula
	# si una de las valencias es mayor a uno entonces se le agrega como string el valor
	# ej: si la el simbolo es Fe y las valencias son 2 y 1 entonce se agregaria 
	# A Fe el valor quedaria FeO2 y lo retornariamos en el script de mesa de pociones
	var formula = metal.simbolo
	if valencia_m > 1: formula += str(valencia_m)
	
	formula += "O"
	if valencia_o > 1: formula += str(valencia_o)
	
	return formula

static func divisor(a: int, b: int):
	
	# a=2 y b=4 se ejecuta el ciclo hasta que b sea igual a 0
	while b != 0:
		#primera vuelta obtiene el residuo de a % b es decir 2 % 4 = 2
		#a tendria el valor de b entonces a = 4
		
		#segunda vuelta obtiene el residuo 4 % 2 = 0
		#a tendria el valor de b entonces a = 2
		var x = b
		b = a % b
		a = x
	
	return a
