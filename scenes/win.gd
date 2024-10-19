extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.has_method('game_end'):
		get_tree().change_scene_to_file("res://scenes/level/win_menu.tscn")
