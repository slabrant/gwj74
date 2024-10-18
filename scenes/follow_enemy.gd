extends CharacterBody2D

@onready var follow_navigation: NavigationAgent2D = $FollowNavigation
const ENEMY_DIE = preload("res://sounds/enemy_die.wav")

@export var FORCE = 55


func die():
	get_tree().root.get_child(0).play_sound(ENEMY_DIE, -25)
	queue_free()


func _physics_process(delta: float) -> void:
	follow_navigation.follow(delta)
	move_and_slide()


func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.has_method('hurt'):
		body.hurt(10)
		die()
	if body.has_method('stun'):
		body.stun(self.position)
