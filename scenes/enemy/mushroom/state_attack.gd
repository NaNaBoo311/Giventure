extends State

@export var chasing_state : State

func state_input(event: InputEvent):
	pass
	
func on_enter():
	playback.travel("attack")

func on_exit():
	pass

func state_process(delta):
	pass

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == 'attack':
		next_state = chasing_state
