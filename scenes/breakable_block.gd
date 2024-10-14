extends CharacterBody2D


func die():
	queue_free()


func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.has_method('hurt'):
		body.hurt(30)
		die()
