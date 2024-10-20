extends CharacterBody2D

@onready var jump_sound: AudioStreamPlayer2D = $JumpSound
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var cart = %Cart
@onready var shot_timer: Timer = $ShotTimer
@onready var stun_timer: Timer = $StunTimer

const BULLET = preload("res://scenes/bullet.tscn")
const SHOOT = preload("res://sounds/shoot.wav")

const SPEED = 150.0
const BULLET_SPEED = 150.0
const JUMP_VELOCITY = -300.0

@export var crouch_ratio = 0.80:
	set(value):
		crouch_ratio = round(value * 24) / 24


func _physics_process(delta: float) -> void:
	move_and_slide()
	velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if 0 < stun_timer.time_left:
		return

	if Input.is_action_just_pressed("input_activate") and cart.fixable:
		cart.fixing = true
	
	if Input.is_action_just_pressed("input_shoot"):
		shoot(position, get_global_mouse_position())
		cart.fixing = false

	var direction := Input.get_axis("input_left", "input_right")
	if Input.is_action_just_pressed("input_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		sprite.play('jump')
		jump_sound.play()
	elif is_on_floor():
		if direction:
			sprite.play('walk')
		elif cart.fixing:
			sprite.play('fix')
			cart.fix(delta)
		else:
			sprite.play('idle')
	
	if Input.is_action_just_pressed("input_duck"):
		position.y += (1 - crouch_ratio) * 24 # 24 is sprite height
		
	if Input.is_action_pressed("input_duck"):
		scale.y = crouch_ratio
	else:
		scale.y = 1.00

	if direction:
		velocity.x = direction * SPEED
		sprite.flip_h = direction != 1


func game_end():
	get_tree().root.get_child(0).game_end()


func stun(other_position: Vector2):
	var x_norm_pos: int = 1 if 0 < (position - other_position).x else -1
	velocity = Vector2(x_norm_pos * 100, -100)
	stun_timer.start()


func shoot(start_position: Vector2, end_position: Vector2):
	if 0 < shot_timer.time_left:
		return
	shot_timer.start()
	get_tree().root.get_child(0).play_sound(SHOOT, -25)
	var bullet = BULLET.instantiate()
	bullet.position = start_position
	bullet.velocity = (end_position - start_position).normalized() * BULLET_SPEED
	add_sibling(bullet)
	
