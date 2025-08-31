extends ProgressBar

class_name DefaultHealthBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show_percentage = false
	value = 50
	
	var background_style = StyleBoxFlat.new()
	background_style.bg_color = Color.BLACK
	background_style.border_width_left = 1
	background_style.border_width_right = 1
	background_style.border_width_top = 1
	background_style.border_width_bottom = 1
	background_style.corner_radius_top_right = 3
	background_style.corner_radius_bottom_right = 3
	add_theme_stylebox_override("background", background_style)

	var fill_style = StyleBoxFlat.new()
	fill_style.bg_color = Color.RED
	fill_style.border_width_left = 1
	fill_style.border_width_right = 1
	fill_style.border_width_top = 1
	fill_style.border_width_bottom = 1
	fill_style.corner_radius_bottom_left = 3
	fill_style.corner_radius_top_left = 3
	add_theme_stylebox_override("fill", fill_style)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
