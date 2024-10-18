extends Area2D

@export var active: bool = true:
	set(value):
		activate()
@export var targets: Array

func activate():
	for target in targets:
		if target.has_method('die'):
			target.die()
		else:
			target.queue_free()
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	targets.append(body)


func _on_body_exited(body: Node2D) -> void:
	var target_pos = targets.find(body)
	targets.remove_at(target_pos)
