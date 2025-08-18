extends ColorRect

@export var max_height : float = 5000  # max height of your balloon
@export var colors := [Color(0.0, 0.0, 0.2),  # dark blue at ground
					   Color(0.4, 0.7, 1.0),  # lighter "thin air"
					   Color(0.05, 0.05, 0.1)]  # very dark space

func _process(delta):
	var player = get_node("/root/MainScene/Player")  # adjust path
	var t = clamp(player.global_position.y / max_height, 0, 1)
	
	# Split the gradient into two segments
	if t < 0.5:
		color = colors[0].lerp(colors[1], t / 0.5)  # bottom to middle
	else:
		color = colors[1].lerp(colors[2], (t - 0.5) / 0.5)  # middle to top
