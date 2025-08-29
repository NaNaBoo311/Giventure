extends Node

class_name CharacterStateMachine
var states: Array[State]
@export var current_state : State
@export var character: CharacterBody2D
@export var animation_tree : AnimationTree
func _ready() -> void:
	for child in get_children():
		if child is State:
			states.append(child)
			#Set the states up to what they need to function
			child.character = character
			child.playback = animation_tree["parameters/playback"]
			child.animation_tree = animation_tree
		else:
			push_warning("Child " + child.name + " is not a State in CharacterStateMachine")
	if current_state != null:
		current_state.on_enter()
			

func _physics_process(delta: float) -> void:
	if current_state.next_state != null:
		switch_state(current_state.next_state)
	current_state.state_process(delta)

func check_can_move():
	return current_state.can_move

func switch_state(new_state:State):
	if current_state != null:
		current_state.on_exit()
		current_state.next_state = null
	current_state = new_state
	current_state.on_enter()

func _input(event: InputEvent):
	if current_state != null:
		current_state.state_input(event)
