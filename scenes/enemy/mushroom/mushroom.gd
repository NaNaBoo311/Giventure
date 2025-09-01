extends CharacterBody2D


@onready var animation_tree: AnimationTree = $AnimationTree
@onready var vision_area: Area2D = $VisionArea
@onready var ground_ray_cast_2D: RayCast2D = $GroundGrayCast2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hitbox_area_2d: Area2D = $HitboxArea2D
@onready var attack_zone: Area2D = $AttackZone
@onready var wall_ray_cast_2d: RayCast2D = $WallRayCast2D

#Special character attributes
@export var chasing_speed : float 
@export var direction : int = -1
@export var speed: float = 50
@export var attack_damage : int = 5
@export var max_health : int
@export var health: int = 50:
	get:
		return health
	set(value):
		var damage : int = health - value
		SignalBus.emit_signal("on_health_change", self, damage)
		health = value


func _ready() -> void:
	add_to_group("enemy")
	chasing_speed = speed * 4
	animation_tree.active = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
func update_facing_direction():
	if not ground_ray_cast_2D.is_colliding():
		direction *= -1
	elif wall_ray_cast_2d.is_colliding():
		direction *= -1
		
	if direction > 0:  # facing left
		sprite_2d.flip_h = true
		if vision_area.position.x < 0:
			ground_ray_cast_2D.position.x *= -1
			wall_ray_cast_2d.position.x *= -1
			vision_area.position.x *= -1
			hitbox_area_2d.position.x *= -1
			attack_zone.position.x *= -1
			
	elif direction < 0: # facing right
		sprite_2d.flip_h = false
		if vision_area.position.x > 0:
			ground_ray_cast_2D.position.x *= -1
			wall_ray_cast_2d.position.x *= -1
			vision_area.position.x *= -1
			hitbox_area_2d.position.x *= -1
			attack_zone.position.x *= -1

func get_hit(damage : int):
	health -= damage
	if (health <= 0):
		animation_tree.set("parameters/conditions/die", true)

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "die":
		queue_free()
