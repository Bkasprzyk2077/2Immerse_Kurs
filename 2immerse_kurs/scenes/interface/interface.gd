extends CanvasLayer
class_name PLAYER_INTERFACE

static var INTERFACE_INSTANCE

func _ready() -> void:
	INTERFACE_INSTANCE = self

func update_health(hp_amount):
	%HealthLabel.text = "HP: " + str(hp_amount)

func update_coins(coins_amount):
	%CoinLabel.text = "Coins: " + str(coins_amount)
