extends CharacterBody2D

@export var acceleration: float = 300.0
@export var max_speed: float = 150.0
@export var friction: float = 200.0
@export var buoyancy: float = 50.0  # how strong the natural upward drift is

func _physics_process(delta):
	var input_dir = Vector2.ZERO

	# Horizontal input
	if Input.is_action_pressed("ui_right"):
		input_dir.x += 1
	if Input.is_action_pressed("ui_left"):
		input_dir.x -= 1
	
	# Vertical control
	if Input.is_action_pressed("ui_down"):
		input_dir.y += 1   # vent gas = sink
	elif Input.is_action_pressed("ui_up"):
		input_dir.y -= 1   # extra lift (like releasing ballast)

	# Apply buoyancy (natural upward drift) when NOT pressing down
	if not Input.is_action_pressed("ui_down"):
		velocity.y -= buoyancy * delta  

	# Accelerate toward input
	if input_dir != Vector2.ZERO:
		input_dir = input_dir.normalized()
		velocity = velocity.move_toward(input_dir * max_speed, acceleration * delta)
	else:
		# Apply drag
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	move_and_slide()
