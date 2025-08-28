extends State

@onready var timer: Timer = $Timer
@export var ground_state: State
func on_enter():
	playback.travel("attack1")
	
func state_input(event: InputEvent):
	if event.is_action_pressed("attack"):
		timer.start()
	
func state_process(delta):
	pass
	
func on_exit():
	pass
	
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == 'attack1':
		if timer.is_stopped():
			next_state = ground_state
		else:
			playback.travel("attack2")
	elif anim_name == 'attack2':
		next_state = ground_state
