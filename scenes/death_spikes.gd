extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if 0 < body.velocity.y and body.has_method("game_end"):
		body.game_end()
