extends Node2D

@export var ground_color : Color = Color8(63, 155, 11, 255) # Grass green
@export var ground_y : float = 50 # vertical position of the ground in world space

var shape : RectangleShape2D

func _ready():
	# Setup visual block
	var rect = $ColorRect
	rect.color = ground_color
	rect.anchor_left = 0
	rect.anchor_right = 1
	rect.anchor_top = 0
	rect.anchor_bottom = 0
	rect.set_custom_minimum_size(Vector2(1, 1)) # temporary, updated in _process

	# Setup collision
	shape = RectangleShape2D.new()
	shape.size = Vector2(1, 1) # temporary, updated in _process
	$StaticBody2D/CollisionShape2D.shape = shape

	# Fix ground at world Y position
	position.y = ground_y

func _process(_delta):
	var viewport_size = get_viewport().size
	var camera = get_viewport().get_camera_2d()
	if camera == null:
		return
	
	var cam_pos = camera.global_position

	# Make ground extra wide and tall to cover screen fully
	var width = viewport_size.x * 8.0 # TODO: Should be set to a fixed screen/camera size.
	var height = viewport_size.y * 8.0 # TODO: Should be set to a fixed screen/camera size.

	# Update visual rectangle
	$ColorRect.set_custom_minimum_size(Vector2(width, height))
	$ColorRect.position = Vector2(cam_pos.x - width / 2, ground_y)

	# Update collision shape
	shape.size = Vector2(width, height)
	$StaticBody2D/CollisionShape2D.shape = shape
	$StaticBody2D.position.x = cam_pos.x
	$StaticBody2D.position.y = ground_y + height / 2  # center collision vertically
