extends Control

@export var health_change_label : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("on_health_change", on_signal_health_change)

func on_signal_health_change(node: Node, amount: int):
	var label_instance : Label = health_change_label.instantiate()
	label_instance.text = str(amount)
	node.add_child(label_instance)
	
	
