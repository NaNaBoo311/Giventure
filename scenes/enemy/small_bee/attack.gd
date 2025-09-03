extends State
@export var fly_state : State

func on_enter():
	playback.travel("attack")

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") && body.is_alive:
		body.get_hit(character.attack_damage)
	
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == 'attack':
		next_state = fly_state
