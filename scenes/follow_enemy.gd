extends CharacterBody2D

@onready var follow_navigation: NavigationAgent2D = $FollowNavigation

@export var FORCE = 55


func die():
	queue_free()


func _physics_process(delta: float) -> void:
	follow_navigation.follow(delta)
	move_and_slide()


func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.has_method('hurt'):
		body.hurt(10)
		die()
