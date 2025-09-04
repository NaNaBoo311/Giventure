extends State


func on_enter():
	character.is_alive = false
	character.animation_tree.set("parameters/conditions/die", true)
	character.set_collision_layer_value(4, false)
