extends Node2D

@export var max_height : float = 5000

func _process(delta):
	var players = get_tree().get_nodes_in_group("player")
	if players.size() == 0:
		return
	var player = players[0]

	# t = 0 at ground, 1 at max_height
	var t = clamp(player.global_position.y / max_height, 0, 1)

	# Interpolate colors based on player height

	# Apply to shader
	var bg_mat = $Background.material
