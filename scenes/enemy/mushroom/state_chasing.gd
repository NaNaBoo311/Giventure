extends State
@onready var timer: Timer = $Timer
@export var attack_state: State
@export var ground_state: State
var player_in_range: bool = false
var player : CharacterBody2D


func on_enter():
	timer.start(3)
	playback.travel("chasing")

 
func state_process(delta):
	#Move the character
	character.velocity.x = character.direction * character.chasing_speed
	character.move_and_slide()
	
	#Change direction
	character.update_facing_direction()
	
	#Change to attack state if the player is in range & alive
	if player_in_range && player != null && player.is_alive:
		next_state = attack_state


func _on_attack_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") && body.is_alive == true:
		player = body
		player_in_range = true
		timer.stop()

func _on_attack_zone_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		timer.start(3)


func _on_timer_timeout() -> void:
	next_state = ground_state
