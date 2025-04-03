extends Sprite2D

@onready var cannon: Sprite2D = $Cannon

var speed: float = 200.0
var acceleration: float = 1000.0
var friction: float = 600.0

var velocity_x: float = 0.0
var projectile_container: Node

func set_projectile_container(container: Node):
	cannon.projectile_container = container
	projectile_container = container

func _physics_process(delta):
	var input_dir = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	var mouse_position: Vector2 = get_global_mouse_position()
	cannon.look_at(mouse_position)

	if Input.is_action_just_pressed("fire"):
		cannon.fire()

	if input_dir != 0:
		velocity_x = move_toward(velocity_x, input_dir * speed, acceleration * delta)
	else:
		# Aplicar fricción cuando no hay input
		velocity_x = move_toward(velocity_x, 0, friction * delta)

	# Aplicar movimiento
	position.x += velocity_x * delta
