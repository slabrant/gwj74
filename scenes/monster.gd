extends CharacterBody2D


const SPEED = 1200.0
@onready var cart = %Cart


func _physics_process(delta: float) -> void:
	if cart and 300 < cart.position.x - position.x:
		velocity.x = 2 * SPEED * delta
	else:
		velocity.x = SPEED * delta
	move_and_slide()


func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.has_method('game_end'):
		body.game_end()
