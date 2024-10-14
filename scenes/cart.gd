extends CharacterBody2D

@onready var fix_label: Label = $FixLabel

const HEALTH_MAX = 100
const SPEED_MAX = 15.0
@export var speed: float = SPEED_MAX * HEALTH_MAX
@export var health: int = HEALTH_MAX:
	set(value):
		if value <= 0:
			value = 0
		elif HEALTH_MAX <= value:
			value = HEALTH_MAX
			fixing = false
		if fixable:
			fix_label.visible = value < HEALTH_MAX
		health = value
		speed = SPEED_MAX * value
@export var fixable: bool = false:
	set(value):
		fixable = value
		if (value == true and health < HEALTH_MAX) or value == false:
			fix_label.visible = value
@export var fixing: bool = false:
	set(value):
		fixing = value
@export var fix_speed: float = 75.00


func _physics_process(delta: float) -> void:
	velocity.x = speed * delta
	move_and_slide()


func game_end():
	get_tree().root.get_child(0).game_end()

func fix(delta):
	health += fix_speed * delta

func hurt(amount):
	health -= amount


func _on_fix_area_body_entered(body: Node2D) -> void:
	fixable = true


func _on_fix_area_body_exited(body: Node2D) -> void:
	fixing = false
	fixable = false
