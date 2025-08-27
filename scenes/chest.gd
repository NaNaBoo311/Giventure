extends Node2D

@onready var sprite = $AnimatedSprite2D
var player_nearby = false
var is_open = false

func _ready():
	sprite.play("default")

func _process(delta):
	if player_nearby and not is_open:
		if Input.is_action_just_pressed("attack"):
			open_chest()
	
	
func open_chest():
	is_open = true
	sprite.play("open")
	await sprite.animation_finished
	queue_free() # chest disappears


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_nearby = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_nearby = false
