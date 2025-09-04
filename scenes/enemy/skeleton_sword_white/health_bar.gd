extends ProgressBar
@export var character : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_value = character.max_health
	value = character.health
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value = character.health
	if value != max_value:
		visible = true
