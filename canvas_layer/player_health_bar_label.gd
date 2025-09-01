extends Label

@onready var player: CharacterBody2D = get_parent().player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = str(player.health) + "/" + str(player.max_health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = str(player.health) + "/" + str(player.max_health)
