extends CharacterBody2D

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine
@onready var sword_attack_2d_area: Area2D = $SwordAttack2DArea

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var direction : Vector2 = Vector2.ZERO

func _ready() -> void:
	add_to_group("player")
	animation_tree.active = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	if direction.x != 0 && state_machine.check_can_move():
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	update_animation()
	update_facing_direction()
	
func update_animation():
	animation_tree.set("parameters/Move/blend_position", direction.x)

func update_facing_direction():
	if direction.x > 0: #facing right
		if sword_attack_2d_area.position.x < 0:
			sword_attack_2d_area.position.x *= -1
		sprite_2d.flip_h = false
	elif direction.x < 0:
		if sword_attack_2d_area.position.x > 0:
			sword_attack_2d_area.position.x *= -1
		sprite_2d.flip_h = true
