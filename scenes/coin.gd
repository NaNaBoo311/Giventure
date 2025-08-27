extends RigidBody2D
@onready var sprite = $AnimatedSprite2D

func _ready():
	sprite.play("default")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"): 
		print("Player picked up coin!") 
		queue_free() # remove coin
