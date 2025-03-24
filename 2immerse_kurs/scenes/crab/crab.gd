extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 50.0
var direction = -1


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if $LeftWallDetector.is_colliding(): direction = 1
	elif $RightWallDetector.is_colliding(): direction = -1
	
	animate()
	move_and_slide()

func animate():
	if velocity.x > 0:
		animated_sprite_2d.flip_h = true
	elif velocity.x < 0:
		animated_sprite_2d.flip_h = false


func _on_attack_area_2d_body_entered(body: Node2D) -> void:
	print(body)
