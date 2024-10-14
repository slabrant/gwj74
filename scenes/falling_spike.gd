extends CharacterBody2D


const GRAVITY = 1000.0

@export var falling: bool = false


func die():
	queue_free()


func _physics_process(delta: float) -> void:
	if falling:
		velocity.y += delta * GRAVITY
	move_and_slide()


func _on_detection_area_body_entered(body: Node2D) -> void:
	falling = true


func _on_hurt_area_body_entered(body: Node2D) -> void:
	if body.has_method('hurt'):
		body.hurt(30)
		die()
