extends CharacterBody2D

# Movement
@export var moveSpeed : float = 150
var moveDirection : Vector2

# Planting
var seed_count : int = 0
@export var flower_scene : PackedScene
@onready var animated_sprite_2d = $AnimatedSprite2D
# Distance to check left/right
@export var plant_range: float = 16.0

# Map Size
# 30 x 20 Tiles

func _process(delta):
	if Input.is_action_just_pressed("Space") and seed_count > 0:
		plant_seed()


func _physics_process(delta):
	moveDirection.x = Input.get_axis("Left", "Right")
	moveDirection.y = Input.get_axis("Up", "Down")
	moveDirection = moveDirection.normalized() # Si diagonal movement not faster
	
	if moveDirection.x > 0:
		animated_sprite_2d.flip_h = true
	elif moveDirection.x < 0:
		animated_sprite_2d.flip_h = false
	
	if moveDirection:
		velocity = moveDirection * moveSpeed
		animated_sprite_2d.play("walk")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, moveSpeed)
		animated_sprite_2d.play("idle")
	
	move_and_slide()


func add_seed():
	seed_count += 1
	UI.add_seeds(1)
	#print("Seeds: ", seed_count)


func plant_seed():
	if seed_count <= 0:
		return  # No seeds left, can't plant
	
	# Find all PlantTile nodes in the scene
	for tile in get_tree().get_nodes_in_group("plant_tiles"):
		if tile.occupied:
			continue
		
		# Check if tile is within the range of the player
		var dist = global_position.distance_to(tile.global_position)
		
		if dist <= plant_range: # roughly same row
			# Plant flower at tile position
			$SeedSFX.play()
			var flower = flower_scene.instantiate()
			flower.global_position = tile.global_position
			tile.get_parent().add_child(flower)
			
			# Mark tile as used
			tile.occupied = true
			tile.queue_free()
			
			seed_count -= 1
			UI.use_seed()
			
			if is_instance_valid(flower):
				UI.add_score(1)      # +1 score
				UI.add_time(1)       # add 1 seconds
				await get_tree().create_timer(1.0).timeout
				flower.queue_free()
			return
			
