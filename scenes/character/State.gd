extends Node
class_name State

@export var can_move = true

var character : CharacterBody2D # Passed in from CharacterStateMachine
var next_state: State

func state_input(event: InputEvent):
	pass
	
func on_enter():
	pass

func on_exit():
	pass
