extends State

@export var idle_state: State
@export var min_walk_time: float = 6.0   # minimum seconds before switching
@export var max_walk_time: float = 8.0   # maximum seconds before switching

var time_to_switch: float = 0.0
var elapsed: float = 0.0
var direction: int = 0

func on_enter():
	playback.travel("walk")
	# pick a random walk time
	time_to_switch = randf_range(min_walk_time, max_walk_time)
	elapsed = 0.0

	# pick a random horizontal direction (-1 = left, +1 = right)
	direction = -1 if randf() < 0.5 else 1
	character.direction.x = direction

func state_process(delta):
	elapsed += delta

	# move the enemy
	character.velocity.x = character.direction.x * character.speed
	character.update_facing_direction()
	if elapsed >= time_to_switch:
		next_state = idle_state
	
	character.move_and_slide()
