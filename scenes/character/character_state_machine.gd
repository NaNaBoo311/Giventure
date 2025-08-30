extends Node

class_name CharacterStateMachine
var states: Array[State]
@export var current_state : State
@export var character: CharacterBody2D
@export var animation_tree : AnimationTree
@export var vision_area : Area2D
@export var ground_ray_cast_2D: RayCast2D
@export var wall_ray_cast_2D: RayCast2D

func _ready() -> void:
	for child in get_children():
		if child is State:
			states.append(child)
			#Set the states up to what they need to function
			child.character = character
			child.playback = animation_tree["parameters/playback"]
			child.animation_tree = animation_tree
			child.vision_area = vision_area
			child.ground_ray_cast_2D = ground_ray_cast_2D
			child.wall_ray_cast_2D = wall_ray_cast_2D
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
