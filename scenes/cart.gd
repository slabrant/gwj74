extends CharacterBody2D


@export var SPEED: float = 50.0
@export var HEALTH: int = 100:
	set(value):
		HEALTH = value
		SPEED = 0.5 * HEALTH
		print(value)

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := 1
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func hurt(amount):
	HEALTH -= amount
