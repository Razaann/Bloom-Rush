extends CharacterBody2D

@export var moveSpeed : float = 150
var moveDirection : Vector2

@onready var animated_sprite_2d = $AnimatedSprite2D


# Map Size
# 12 x 18 Tiles

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
