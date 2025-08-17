extends Node2D

@export var seed_scene: PackedScene
@export var plant_tile_scene: PackedScene

@export var map_width := 28
@export var map_height := 18
@export var tile_size := 16   # size of your grid tile
@onready var spawner_timer = $SpawnerTimer

var used_positions: Array = [] # keep track of occupied spots

func _ready():
	randomize()
	# Spawn initial batch
	spawn_seeds(5)
	spawn_plant_tiles(3)

func get_random_position() -> Vector2:
	var pos: Vector2
	while true:
		# pick random tile in range (negative to positive)
		var x = (randi() % map_width - map_width / 2) * tile_size
		var y = (randi() % map_height - map_height / 2) * tile_size
		pos = Vector2(x, y)

		# only accept if not overlapping
		if not used_positions.has(pos):
			used_positions.append(pos)
			break
	return pos

func spawn_seeds(amount: int):
	for i in range(amount):
		var seeds = seed_scene.instantiate()
		seeds.position = get_random_position()
		add_child(seeds)

func spawn_plant_tiles(amount: int):
	for i in range(amount):
		var tile = plant_tile_scene.instantiate()
		tile.position = get_random_position()
		add_child(tile)

func _on_spawner_timer_timeout():
	spawn_seeds(3)       # spawn 2 seeds per tick
	spawn_plant_tiles(3) # spawn 1 tile per tick
