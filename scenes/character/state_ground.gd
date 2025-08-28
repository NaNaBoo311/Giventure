extends State

class_name GroundState

@export var jump_velocity : float = -400.0
@export var air_state : State
@export var attack_state: State
@export var jump_node : String = 'jump_start'
@export var attack_node: String = 'attack1'
func state_input(event: InputEvent):
	if (event.is_action_pressed("jump")):
		jump()
	elif (event.is_action_pressed("attack")):
		attack()
		
func on_enter():
	playback.travel("Move")

func on_exit():
	pass

func jump():
	character.velocity.y = jump_velocity
	next_state = air_state	
	playback.travel(jump_node)

func attack():
	next_state = attack_state
	
func state_process(delta):
	if !character.is_on_floor():
		next_state = air_state
