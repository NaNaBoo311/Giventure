extends State

@export var min_idle_time: float = 0.5
@export var max_idle_time: float = 2.0
@export var min_run_time: float = 1.0
@export var max_run_time: float = 3.0
@export var chasing_state : State

var _is_idle = false
var _state_timer: float = 0.0

func on_enter():
	playback.travel("move")
	_set_idle() 
	
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
		#Move the character
		character.velocity.x = character.direction * character.speed
		character.move_and_slide()
		
		#Update aniamtion & facing direction
		animation_tree.set("parameters/move/blend_position", character.direction)
		character.update_facing_direction()

func _set_idle():
	_is_idle = true
	_state_timer = randf_range(min_idle_time, max_idle_time)
	character.velocity.x = 0
	animation_tree.set("parameters/move/blend_position", 0)

func _set_run():
	_is_idle = false
	_state_timer = randf_range(min_run_time, max_run_time)

func _on_vision_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		next_state = chasing_state
