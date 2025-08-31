extends State


func on_enter():
	animation_tree.set("parameters/conditions/die", true)
	character.is_alive = false
	character.set_collision_mask_value(4, false) #Unmask enemy so its collision wont detect enemy --> body wont be pushed
