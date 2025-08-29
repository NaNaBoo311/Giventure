extends State

@export var speed: float = 50
@export var vision_area : Area2D 
@export var ground_ray : RayCast2D
@export var min_idle_time: float = 0.5
@export var max_idle_time: float = 2.0
@export var min_run_time: float = 1.0
@export var max_run_time: float = 3.0

var _direction = 1
var _is_idle = false
var _state_timer: float = 0.0

func on_enter():
	_set_idle() # start idle or you can call _set_run() to start running
	

func state_process(delta):
	_state_timer -= delta
	if _state_timer <= 0:
		# Switch state randomly
		if _is_idle:
			_set_run()
		else:
			_set_idle()

	if _is_idle:
		# Idle → no movement
		character.velocity.x = 0
		animation_tree.set("parameters/move/blend_position", 0)
	else:
		# No platform ahead → turn around
		if not ground_ray.is_colliding():
			_direction *= -1

		character.velocity.x = _direction * speed
		character.move_and_slide()
		animation_tree.set("parameters/move/blend_position", _direction)
		update_facing_direction(_direction)


func update_facing_direction(direction: int):
	if direction > 0:  # facing left
		character.get_node("Sprite2D").flip_h = true
		if vision_area.position.x < 0:
			ground_ray.position.x *= -1
			vision_area.position.x *= -1
	elif direction < 0: # facing right
		character.get_node("Sprite2D").flip_h = false
		if vision_area.position.x > 0:
			ground_ray.position.x *= -1
			vision_area.position.x *= -1


func _set_idle():
	_is_idle = true
	_state_timer = randf_range(min_idle_time, max_idle_time)
	character.velocity.x = 0
	animation_tree.set("parameters/move/blend_position", 0)

func _set_run():
	_is_idle = false
	_state_timer = randf_range(min_run_time, max_run_time)
