extends State

var origin: Vector2 
var target_point: Vector2
var player: Node2D = null
var player_in_attack_zone : bool = false
@export var attack_state: State
func on_enter():
	if player_in_attack_zone && player && player.is_alive:
		next_state = attack_state
	if origin == Vector2.ZERO:
		origin = character.global_position
	_pick_new_target()

func state_process(delta: float):
	if player_in_attack_zone && player && player.is_alive: #Switch to Attack state
		next_state = attack_state
	
	if player && player.is_alive:  #  Chase mode
		var direction = (player.global_position - character.global_position).normalized()
		character.direction = direction
		character.update_facing_direction()
		character.velocity = direction * character.chasing_speed
	else:       #  Roam mode
		if character.global_position.distance_to(target_point) < 5.0:
			_pick_new_target()
		var direction = (target_point - character.global_position).normalized()
		character.direction = direction
		character.update_facing_direction()
		character.velocity = direction * character.speed
	
	character.move_and_slide()

func _pick_new_target():
	var angle = randf() * TAU
	var radius = randf() * character.roam_radius
	target_point = origin + Vector2(cos(angle), sin(angle)) * radius

func _on_vision_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") && body.is_alive:
		player = body

func _on_vision_area_body_exited(body: Node2D) -> void:
	if body == player:
		player = null

func _on_attack_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") && body.is_alive:
		player_in_attack_zone = true

func _on_attack_zone_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_attack_zone = false
