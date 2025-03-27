extends Node

@export var current_coins: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for coin in get_tree().get_nodes_in_group("coins"):
		coin.coin_collected.connect(add_coin)
	
func add_coin():
	current_coins += 1
	if current_coins == 3:
		var player = get_tree().get_first_node_in_group("player")
		player.current_health += 1
		PLAYER_INTERFACE.INTERFACE_INSTANCE.update_health(player.current_health)
		current_coins = 0
	PLAYER_INTERFACE.INTERFACE_INSTANCE.update_coins(current_coins)
