extends CharacterBody2D

class_name ENEMY

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 50.0
var direction = -1
var can_move: bool = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if direction and can_move:
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
	if body is PLAYER:
		attack(body)

func attack(player: PLAYER):
	player.get_hit()
	knockback(player)
	can_move = false
	animated_sprite_2d.play("attack")
	await animated_sprite_2d.animation_finished
	can_move = true
	animated_sprite_2d.play("run")
	
func knockback(player: PLAYER):
	var direction_to_player = (global_position - Vector2(0,-10)).direction_to(player.global_position)
	player.velocity = direction_to_player * 800

func get_hit():
	can_move = false
	animated_sprite_2d.play("death")
	$LeftWallDetector.enabled = false
	$RightWallDetector.enabled = false
	$AttackArea2D.queue_free()
	set_collision_layer_value(2, false)
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
