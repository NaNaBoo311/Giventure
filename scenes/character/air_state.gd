extends State
class_name AirState
@export var ground_state : State
@export var double_jump_velocity : float = -200
@export var double_jump_animation : String = "jump"
var can_double_jump : bool

func on_enter():
	can_double_jump = true

func on_exit():
	playback.travel("jump_end")

func state_process(delta):
	if character.is_on_floor():
		next_state = ground_state

func state_input(event: InputEvent):
	if (event.is_action_pressed("jump") && can_double_jump):
		double_jump()

func double_jump():
	character.velocity.y = double_jump_velocity
	playback.travel(double_jump_animation)
	can_double_jump = false
