extends Node
class_name State

@export var can_move = true
# Passed in from CharacterStateMachine
var character : CharacterBody2D 
var playback: AnimationNodeStateMachinePlayback 
var animation_tree: AnimationTree
var vision_area: Area2D
var ground_ray_cast_2D : RayCast2D
var wall_ray_cast_2D : RayCast2D
var next_state: State

func state_input(event: InputEvent):
	pass
	
func on_enter():
	pass

func on_exit():
	pass

func state_process(delta):
	pass
