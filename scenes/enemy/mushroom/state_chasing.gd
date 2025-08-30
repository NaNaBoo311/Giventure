extends State

@export var attack_state: State
var player_in_range: bool = false


func state_input(event: InputEvent):
	pass
	
func on_enter():
	playback.travel("chasing")

func on_exit():
	pass
 
func state_process(delta):
	#Move the character
	character.velocity.x = character.direction * character.chasing_speed
	character.move_and_slide()
	
	#Change direction
	character.update_facing_direction()
	
	#Change to attack state if the player is in range
	if player_in_range:
		next_state = attack_state
		
	
func _on_attack_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true

func _on_attack_zone_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
