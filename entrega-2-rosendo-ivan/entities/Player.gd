extends Sprite2D

@export var speed := 200.0

func _physics_process(delta):
	var direction := Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1

	if direction != Vector2.ZERO:
		direction = direction.normalized()
		position += direction * speed * delta
