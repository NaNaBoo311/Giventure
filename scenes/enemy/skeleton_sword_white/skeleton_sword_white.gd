extends CharacterBody2D

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var character_state_machine: CharacterStateMachine = $CharacterStateMachine
@onready var ground_ray_cast_2d: RayCast2D = $GroundRayCast2D
@onready var wall_cast_2d: RayCast2D = $WallCast2D
@onready var attack_zone: Area2D = $AttackZone
@onready var hitbox: Area2D = $Hitbox
@onready var hit_flash_animation_player: AnimationPlayer = $HitFlashAnimationPlayer
@onready var attack_state: Node = $CharacterStateMachine/Attack
@onready var walk_state: Node = $CharacterStateMachine/Walk
@onready var die_state: Node = $CharacterStateMachine/Die

@export var speed: int = 50
@export var direction : Vector2 
@export var attack_damage: int = 1
@export var max_health : int = 60
@export var health: int = 60:
	get:
		return health
	set(value):
		var damage : int = health - value
		SignalBus.emit_signal("on_health_change", self, damage)
		health = value

func _ready() -> void:
	add_to_group("enemy")
	animation_tree.active = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

func update_facing_direction():
	if not ground_ray_cast_2d.is_colliding():
		direction.x *= -1
	elif wall_cast_2d.is_colliding():
		direction.x *= -1
			
	if direction.x > 0: #facing right
		sprite_2d.flip_h = false
		if attack_zone.position.x < 0:
			attack_zone.position.x *= -1
			ground_ray_cast_2d.position.x *= -1
			hitbox.position.x *= -1
	elif direction.x < 0: #facing left
		sprite_2d.flip_h = true
		if attack_zone.position.x > 0:
			attack_zone.position.x *= -1
			hitbox.position.x *= -1
			ground_ray_cast_2d.position.x *= -1

func get_hit(damage : int):
	health -= damage
	hit_flash_animation_player.play("hit_flash")
	if health <= 0:
		character_state_machine.current_state.next_state = die_state
