extends Node2D

@onready var sprite = $AnimatedSprite2D
var player_nearby = false
var is_open = false
var CoinScene = preload("res://scenes/coin.tscn")

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
	drop_items()
	queue_free() # chest disappears

func _on_area_2d_body_entered(body: Node2D) -> void:
	#print(body.get_groups())
	if body.is_in_group("player"):
		print("HERE")
		player_nearby = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_nearby = false

func drop_items():
	for i in range(10):
		var coin = CoinScene.instantiate()
		coin.position = position
		get_parent().add_child(coin)

		# Apply random upward + sideways impulse
		var random_x = randf_range(-150.0, 150.0)
		coin.apply_impulse(Vector2(random_x, -400.0))
