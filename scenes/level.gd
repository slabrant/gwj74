extends Node2D

@onready var navigation_layer: TileMapLayer = $NavigationLayer
@onready var tile_map_layer: TileMapLayer = $TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_navigation()
	pass # Replace with function body.

func generate_navigation():
	var get_rekt = tile_map_layer.get_used_rect()
	for x in range(get_rekt.position.x, get_rekt.position.x + get_rekt.size.x):
		for y in range(get_rekt.position.y, get_rekt.position.y + get_rekt.size.y):
			if tile_map_layer.get_cell_source_id(Vector2(x,y)) != 0:
				navigation_layer.set_cell(Vector2(x,y), 0, Vector2i(0, 0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
