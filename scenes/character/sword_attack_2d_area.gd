extends Area2D

@export var damage : int =  10

func _ready() -> void:
	$CollisionShape2D.disabled = true

	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.get_hit(damage)
