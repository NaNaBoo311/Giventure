extends State


func on_enter():
	character.animation_tree.set("parameters/conditions/die", true)


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == 'die':
		character.queue_free()
