extends Area2D

var occupied := false  # to check if already planted

func plant_flower(flower_scene: PackedScene, pos: Vector2):
	if occupied:
		return
	
	var flower = flower_scene.instantiate()
	flower.position = pos
	get_parent().add_child(flower)
	
	occupied = true
	queue_free() # remove tile after planting
