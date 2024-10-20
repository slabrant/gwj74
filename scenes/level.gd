extends Node2D

@onready var navigation_layer: TileMapLayer = $NavigationLayer
@onready var terrain_layer: TileMapLayer = $TerrainLayer
@onready var bg_music: AudioStreamPlayer2D = $BgMusic

func game_end():
	get_tree().change_scene_to_file("res://scenes/level/lose_menu.tscn")


func _ready() -> void:
	bg_music.play()
	generate_navigation()


func generate_navigation():
	var get_rekt = terrain_layer.get_used_rect()
	for x in range(get_rekt.position.x, get_rekt.position.x + get_rekt.size.x):
		for y in range(get_rekt.position.y, get_rekt.position.y + get_rekt.size.y):
			if terrain_layer.get_cell_source_id(Vector2(x,y)) != 0:
				navigation_layer.set_cell(Vector2(x,y), 0, Vector2i(0, 0))

func play_sound(sound, volume_db):
	var player = AudioStreamPlayer.new()
	player.stream = sound
	player.volume_db = volume_db
	add_child(player)
	player.play()
