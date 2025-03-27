extends Node2D

signal coin_collected

func _on_player_detect_area_2d_body_entered(body: Node2D) -> void:
	if body is PLAYER:
		coin_collected.emit()
		queue_free()
