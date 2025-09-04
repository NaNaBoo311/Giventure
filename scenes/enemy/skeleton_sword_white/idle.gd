extends State

@export var walk_state: State
@export var min_idle_time: float = 1.0   # minimum seconds before switching
@export var max_idle_time: float = 3.0   # maximum seconds before switching

var time_to_switch: float = 0.0
var elapsed: float = 0.0

func on_enter():
	playback.travel("idle")
	# pick a random time before switching
	time_to_switch = randf_range(min_idle_time, max_idle_time)
	elapsed = 0.0

func state_process(delta):
	elapsed += delta
	if elapsed >= time_to_switch:
		next_state = walk_state
