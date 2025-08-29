extends State

@export var speed: float = 50
@export var patrol_distance: float = 100
@export var wait_time: float = 1.0

var _start_x: float
var _direction: int = 1
var _traveled: float = 0.0
var _waiting: bool = false
var _wait_timer: float = 0.0

func on_enter():
	_start_x = character.global_position.x
	_direction = 1
	_traveled = 0.0
	_waiting = false
	# Start idle
	playback.travel("move")  # ensure we're in the BlendSpace

func state_process(delta):
	if _waiting:
		_wait_timer -= delta
		if _wait_timer <= 0.0:
			_waiting = false
			_direction *= -1
		# idle animation while waiting
		animation_tree.set("parameters/move/blend_position", 0)
		return

	# Move enemy
	character.velocity.x = _direction * speed
	character.move_and_slide()

	# Update animation based on direction
	animation_tree.set("parameters/move/blend_position", _direction)

	# Track distance traveled
	_traveled = abs(character.global_position.x - _start_x)
	if _traveled >= patrol_distance:
		character.velocity.x = 0
		_waiting = true
		_wait_timer = wait_time

		# idle while waiting
		animation_tree.set("parameters/move/blend_position", 0)
	
	character.get_node("Sprite2D").flip_h = _direction > 0
