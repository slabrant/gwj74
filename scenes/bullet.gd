extends CharacterBody2D


func _physics_process(delta: float) -> void:
	move_and_slide()


func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.has_method('die'):
		body.die()
	queue_free()
