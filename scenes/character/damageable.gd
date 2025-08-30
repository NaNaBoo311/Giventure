extends Node

@export var health: int = 50:
	get:
		return health
	set(value):
		var damage : int = health - value
		SignalBus.emit_signal("on_health_change", get_parent(), damage)
		health = value

func hit(damage : int):
	health -= damage
	
	if (health <= 0):
		get_parent().queue_free()
