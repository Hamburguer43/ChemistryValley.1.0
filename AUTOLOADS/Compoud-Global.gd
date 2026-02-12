extends Node

var compuestos: Dictionary = {}

##Este autoload es para cargar todos los compuestos (recursos) que tengo creado o vaya a crear
func _ready() -> void:
	var path = "res://ESCENAS/Compound/Resource/"
	var files = DirAccess.get_files_at(path)
	
	for f in files:
		
		#verifica que el archivo que vaya a leer sea un recurso
		if f.ends_with(".tres"):
			
			#abre el archivo y lo convierte en un objeto
			var res = load(path + f) as Compound_Res
			if res:
				#guardamos el resultado en el dicionario creado segun su formula de id
				#si es ej: FeO se guarda como compuestos["FeO"]
				compuestos[res.formula] = res
	
	print("Base de datos cargada: ", compuestos.size(), " compuestos.")

func search_compound(formula: String) -> Compound_Res:
	return compuestos.get(formula, null)
