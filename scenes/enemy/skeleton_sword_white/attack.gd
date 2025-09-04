extends State
var player_in_range : bool = true
@export var walk_state: State

func on_enter():
	playback.travel("attack1")
	player_in_range = true
	character.velocity.x = 0

func state_process(delta):
	pass
	#if player_in_range == false:
		#next_state = walk_state
	
func _on_attack_zone_body_exited(body: Node2D) -> void:
	player_in_range = false

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == 'attack1' && player_in_range:
		playback.start("attack1")
	elif player_in_range == false:
		next_state = walk_state
