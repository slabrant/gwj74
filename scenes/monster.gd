extends CharacterBody2D


const SPEED = 20.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	var direction := 1
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
