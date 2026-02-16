extends Control

@onready var AnimatedBook = $Animated_Book
@onready var Paginas = $Paginas
@onready var Botones = $Botones

func _ready() -> void:
	Paginas.visible = false
	Botones.visible = false
	open_book()

func open_book():
	
	if AnimatedBook:
		AnimatedBook.play("open")
		await AnimatedBook.animation_finished
		Paginas.visible = true
		Botones.visible = true

#Logica de cambair pagina ---------------------------------------
func cambiar_pagina(indice: int):
	
	if Paginas.current_tab == indice:
		return
		
	
	Paginas.visible = false
	Botones.visible = false
	
	if AnimatedBook:
		AnimatedBook.play("Pagina")
		await AnimatedBook.animation_finished
	
	Paginas.current_tab = indice
	Paginas.visible = true
	Botones.visible = true


#Opciones de paginas --------------------------------------------

func _on_compound_pressed() -> void:
	cambiar_pagina(0)

func _on_elements_pressed() -> void:
	cambiar_pagina(1)

func _on_poderes_pressed() -> void:
	cambiar_pagina(2)

func _on_opciones_pressed() -> void:
	cambiar_pagina(3)

func _on_salir_pressed() -> void:
	Paginas.visible = false
	Botones.visible = false
	
	AnimatedBook.play("Close")
	await  AnimatedBook.animation_finished
