extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	frame = randi_range(0,3)
