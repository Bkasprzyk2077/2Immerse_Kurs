extends CharacterBody2D

class_name PLAYER

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

var can_move: bool = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction and can_move:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	animate()
	move_and_slide()

func animate():
	if !can_move: return
	
	if velocity.x > 0:
		animated_sprite_2d.flip_h = false
	elif velocity.x < 0:
		animated_sprite_2d.flip_h = true
		
	if !is_on_floor():
		animated_sprite_2d.play("fall")
		return
		
	if velocity != Vector2.ZERO:
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")
		
		
func get_hit():
	can_move = false
	animated_sprite_2d.play("hit")
	await animated_sprite_2d.animation_finished
	can_move = true


func _on_attack_area_2d_body_entered(body: Node2D) -> void:
	if body is ENEMY:
		velocity.y = JUMP_VELOCITY
		body.get_hit()
