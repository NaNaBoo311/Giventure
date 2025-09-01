extends ProgressBar
const HEALTHBAR_THEME := preload("res://default_healthbar_theme.tres")
@export var character : CharacterBody2D

func _ready():
	theme = HEALTHBAR_THEME
	max_value = character.max_health
	value = character.health
	visible = false

func _process(delta: float) -> void:
	value = character.health
	if value != max_value:
		visible = true
