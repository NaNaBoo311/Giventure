extends CharacterBody2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var attack_zone: Area2D = $AttackZone
@onready var hitbox: Area2D = $Hitbox
@onready var character_state_machine: CharacterStateMachine = $CharacterStateMachine
@onready var die_state: Node = $CharacterStateMachine/Die


@export var speed: int = 50
@export var chasing_speed: int 
@export var roam_radius : float = 100
@export var direction : Vector2 
@export var attack_damage: int = 3
@export var max_health : int = 15
@export var health: int = 15:
	get:
		return health
	set(value):
		var damage : int = health - value
		SignalBus.emit_signal("on_health_change", self, damage)
		health = value
func _ready() -> void:
	add_to_group("enemy")
	chasing_speed = speed * 3
	animation_tree.active = true
	
func update_facing_direction():
	if direction.x > 0: #facing right
		sprite_2d.flip_h = true
		if attack_zone.position.x < 0:
			attack_zone.position.x *= -1
			hitbox.position.x *= -1
	elif direction.x < 0: #facing left
		sprite_2d.flip_h = false
		if attack_zone.position.x > 0:
			attack_zone.position.x *= -1
			hitbox.position.x *= -1

func get_hit(damage : int):
	health -= damage
	if health <= 0:
		character_state_machine.current_state.next_state = die_state
