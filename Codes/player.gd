extends CharacterBody2D

@export var moveSpeed : float = 150
var moveDirection : Vector2
var seed_count : int = 0
@export var flower_scene : PackedScene
@onready var animated_sprite_2d = $AnimatedSprite2D


# Map Size
# 12 x 18 Tiles

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
	print("Seeds: ", seed_count)


func plant_seed():
	var flower = flower_scene.instantiate()
	get_parent().add_child(flower)
	if animated_sprite_2d.flip_h:
		# Create animation of bloom
		flower.global_position = global_position + Vector2(16, 0) # Plant where player is standing
	else:
		# Create animation of bloom
		flower.global_position = global_position + Vector2(-16, 0) # Plant where player is standing 
	
	seed_count -= 1
	print("Planted! Seeds left: ", seed_count)
	
	await get_tree().create_timer(1.0).timeout
	# Create animation of it to go
	flower.queue_free()
