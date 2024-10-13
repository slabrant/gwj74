extends CharacterBody2D

@onready var jump_sound: AudioStreamPlayer2D = $JumpSound
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0


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
		scale.y = 0.75
	else:
		scale.y = 1.0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("input_left", "input_right")
	if direction:
		velocity.x = direction * SPEED
		animated_sprite_2d.flip_h = direction != 1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
