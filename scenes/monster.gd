extends CharacterBody2D


const SPEED = 1200.0


func _physics_process(delta: float) -> void:
	velocity.x = SPEED * delta
	move_and_slide()


func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.has_method('game_end'):
		body.game_end()
