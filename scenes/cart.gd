extends CharacterBody2D

@onready var fix_label: Label = $FixLabel

@export var speed: float = 50.0
const HEALTH_MAX = 100
@export var health: int = HEALTH_MAX:
	set(value):
		if value <= 0:
			value = 0
		elif HEALTH_MAX <= value:
			value = HEALTH_MAX
		if fixable:
			fix_label.visible = value < HEALTH_MAX
		health = value
		speed = 0.5 * value
@export var fixable: bool = false:
	set(value):
		fixable = value
		if (value == true and health < HEALTH_MAX) or value == false:
			fix_label.visible = value

func _physics_process(delta: float) -> void:
	var direction := 1
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	if Input.is_action_just_pressed("input_fix") and fixable:
		fix(20)
	move_and_slide()

func fix(amount):
	health += amount

func hurt(amount):
	health -= amount


func _on_fix_area_body_entered(body: Node2D) -> void:
	fixable = true


func _on_fix_area_body_exited(body: Node2D) -> void:
	fixable = false
