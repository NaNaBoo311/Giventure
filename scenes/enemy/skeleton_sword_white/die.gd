extends State

func on_enter():
	character.animation_tree.active = false
	character.animation_player.play("die")
	character.set_collision_layer_value(4, false)
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "die":
		character.queue_free()
