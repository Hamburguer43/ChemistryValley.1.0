extends Control
class_name table_create_compound

@onready var Inventory_elements: inventario_elements = $"Inventario-Elements"
@onready var SpriteElement = $"Slot-Metal/Button/Sprite2D"
@onready var optionbutton: OptionButton = $VBoxContainer/SelectorValencias

@export var metal_actual: Element_Res
@export var valencia: int = 0

func _ready() -> void:
	
	#conectamos la signal que emitimos en el inventario_elements y le pasamos el metal que seleccionamos
	#que seria elemento: Element_Res
	#Cada vez que se emite esa senal ejecuta el metdodo de metal_elegido
	Inventory_elements.take_metal.connect(metal_elegido)
	

# Guardamos el elemento que elegimos en el inventario y lo guardamos en la var metal_actual
func metal_elegido(elemento: Element_Res):
	metal_actual = elemento
	SpriteElement.texture = metal_actual.icono
	
	optionbutton.clear()
	
	for v in elemento.valencias:
		optionbutton.add_item("Valencia: " + str(v), v)

func _on_button_mezcla_pressed() -> void:
	
	#si no hay un metal elegido pues no va a mezclar nada
	if not metal_actual:
		print("elige un metal para realizar el compuesto")
		return
	
	#Creamos y calculamos la formula utilizando el metodo que está en el script de Logic-create-compound
	#pasandole el metal_actual y la valencia asignada
	
	#creamo un instancia del script dentro de una variable
	var logic_create_compound = Logic_Create_Compound.new()
	valencia = optionbutton.get_selected_id();
	
	var formula = logic_create_compound.create_formula(metal_actual, valencia)
	prints("formula calculada", formula)
	
	#Ya teniendo la formula le vamos a pasar la formula al metodo del autoload que me verifica si ese compuesto existe o no
	#y me devuelve una respuesta null o la formula
	var compound = Compoud_Global.search_compound(formula)
	
	if compound:
		print("creado con exito el compuesto:", compound.formula, "/", compound.nombre)
	else:
		print("compuesto no existente o imposible de mezclar")
		

#RUTA DEL FUNCIONAMIENTO DE TABLE-CREATE-COMPOUND -------------------------------------

#1) El slot-metal es un boton que emite una senal cuando es presionado, esa senal es conectada al script de inventario-elements
#	Cuando se ejecuta la signal aparace el menu cambiando algunas propiedades del nodo y tweens para animaciones

#2) Con el inventario abierto, se va a ejecutar un metodo "create_grid_inventory" que me crea el grid de elementos que tenemos disponibles actualmente,
#	evaluando con un for cuantos elementos hay guardados en el dicionario creado "Elementos", es decir, for in Inventory_Global.elementos
#	si tengo 5 elementos el for seria de 5 donde por cada ciclo crea un slot (que es una escena donde esta definido el slot con los parametro a mostrar)

#3) Cuando se hace pressed en un slot (el elemento que se quiere elegir) emite una senal que ejecuta el metodo "metal_elegido"
#	donde le pasamos el metal(Element_Res) y este me emite una senal que la conectaremos aqui en Table-create-compound pasandole
#	el  metal por le senal Inventory_elements.take_metal.connect(metal_elegido)
#	Esta ejecuta el metodo metal_elegido de aqui y guarda el metal en la variablee metal_actual

#4) Cuando se presiona el boton de mezclar, ejecuta la senal de pressed que primero vberifica si metal_actual tiene algun valor o es null
#	 Utilizamos el metodo de create_formula del script de Logic-create-compound que me crea la formula del compuesto

#5) Teniendo la fomrula lo que hacemos es verificar si existe, utilizando el metodo del autoload Compound_Global.search_compound
#	que busca en el diccionario si existe ese recurso, es decir, utiliza la formula ej: FeO como id para buscar dentro del diccionario los compuestos
# existentes
# Devuelve 2 respuestas, la formula obtenida "oxido ferrico" o null si no existe algun compuesto con los elementos elegidos
