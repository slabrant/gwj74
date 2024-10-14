extends CharacterBody2D

@onready var jump_sound: AudioStreamPlayer2D = $JumpSound
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var cart = %Cart
const BULLET = preload("res://scenes/bullet.tscn")

const SPEED = 150.0
const BULLET_SPEED = 150.0
const JUMP_VELOCITY = -300.0

@export var crouch_ratio = 0.80


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("input_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite_2d.play("jump")
		jump_sound.play()
	elif is_on_floor():
		animated_sprite_2d.play("idle")
	
	if Input.is_action_just_pressed("input_duck"):
		position.y += 8
		
	if Input.is_action_pressed("input_duck"):
		scale.y = crouch_ratio
	else:
		scale.y = 1.00
	
	if Input.is_action_just_pressed("input_shoot"):
		shoot(position, get_global_mouse_position())
		cart.fixing = false

	if Input.is_action_just_pressed("input_fix") and cart.fixable:
		cart.fixing = true
	if cart.fixing:
		cart.fix(delta)

	var direction := Input.get_axis("input_left", "input_right")
	if direction:
		velocity.x = direction * SPEED
		animated_sprite_2d.flip_h = direction != 1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func game_end():
	get_tree().root.get_child(0).game_end()


func shoot(start_position: Vector2, end_position: Vector2):
	var bullet = BULLET.instantiate()
	bullet.position = start_position
	bullet.velocity = (end_position - start_position).normalized() * BULLET_SPEED
	add_sibling(bullet)
	
