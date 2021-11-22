extends Area2D
signal hit

# Declare member variables here
export var speed = 400

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	$AnimatedSprite.play()
	position += velocity * delta
	if velocity.x != 0 || velocity.y != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		if velocity.x != 0:
			$AnimatedSprite.flip_h = velocity.x < 0
	else:
		$AnimatedSprite.animation = "idle"
		$AnimatedSprite.flip_v = false

func _on_Player_body_entered(_body):
	emit_signal("hit")
