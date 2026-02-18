extends Node2D
class_name StateMachine

@export var Initial_State: State
@export var character: CharacterBody2D
@export var animation: AnimationPlayer
@export var animation2: AnimatedSprite2D

var current_state: State
var arrayStates: Array[State]

func _ready() -> void:	
	
	for child in self.get_children():
		
		if child is State:
			child.character = character
			child.animation = animation
			child.state_machine = self
			arrayStates.append(child)
		
	if State:
		current_state = Initial_State
		current_state.enter()

func _physics_process(delta: float) -> void:
	
	if current_state:
		current_state.update_state(delta)

func change_state(target_state_name: String):
	
	var new_state = get_node_or_null(target_state_name)
	
	if new_state == null or new_state == current_state:
		return
		
	current_state.exit()
	new_state.enter()
	current_state = new_state
