extends KinematicBody2D

# Player movement speed
export var speed = 200

func start(pos):
	position = pos

func _physics_process(delta):
	# Get player input
	var direction: Vector2
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# If input is digital, normalize it for diagonal movement
	if abs(direction.x) == 1 && abs(direction.y) == 1:
		direction = direction.normalized()
	
	# Correct Animation
	if direction.x != 0 || direction.y != 0:
		$AnimatedSprite.animation = "run"
		if direction.x != 0:
			$AnimatedSprite.flip_h = direction.x < 0
	else:
		$AnimatedSprite.animation = "idle"
		
	# Apply movement
	var movement = speed * direction
	move_and_slide(movement)
