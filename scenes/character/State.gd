extends Node
class_name State

@export var can_move = true

var character : CharacterBody2D # Passed in from CharacterStateMachine
var playback: AnimationNodeStateMachinePlayback # Passed in from CharacterStateMachine
var next_state: State
var animation_tree: AnimationTree

func state_input(event: InputEvent):
	pass
	
func on_enter():
	pass

func on_exit():
	pass

func state_process(delta):
	pass
