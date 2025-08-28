extends State

class_name GroundState

@export var jump_velocity : float = -400.0
@export var air_state : State

func state_input(event: InputEvent):
	if (event.is_action_pressed("jump")):
		jump()
func on_enter():
	pass

func on_exit():
	pass

func jump():
	character.velocity.y = jump_velocity
	next_state = air_state	
