extends State
var player : CharacterBody2D
var player_in_range : bool = true
@export var walk_state: State

func on_enter():
	playback.travel("attack1")
	player_in_range = true

	
func _on_attack_zone_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == 'attack1' && player_in_range:
		playback.travel("attack2")
	elif anim_name == 'attack2' && player_in_range:
		playback.travel("attack1")
	if player_in_range == false || player.is_alive == false:
		next_state = walk_state

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") && body.is_alive:
		body.get_hit(character.attack_damage)


func _on_attack_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") && body.is_alive:
		player = body
		character.character_state_machine.current_state.next_state = self
