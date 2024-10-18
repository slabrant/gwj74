extends CharacterBody2D


const EXPLODE = preload("res://sounds/explode.wav")


func die():
	get_tree().root.get_child(0).play_sound(EXPLODE, -25)
	queue_free()


func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.has_method('hurt'):
		body.hurt(30)
		die()
