extends Area2D

@onready var activate_label: Label = $ActivateLabel
@onready var sprite: AnimatedSprite2D = $Sprite

@export var bomb_area: Node2D
@export var active: bool = false:
	set(value):
		if active:
			return
		sprite.play()
		active = true
		bomb_area.active = true
@export var player: Node2D:
	set(value):
		if value:
			activate_label.show()
		else:
			activate_label.hide()
		
		player = value
		


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player and Input.is_action_just_pressed("input_activate"):
		active = true


func _on_body_entered(body: Node2D) -> void:
	player = body


func _on_body_exited(body: Node2D) -> void:
	player = null
	pass # Replace with function body.
