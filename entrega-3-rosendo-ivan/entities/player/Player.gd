extends CharacterBody2D
class_name Player
@onready var cannon = $Cannon
@onready var animated_sprite = $AnimatedSprite2D
@export var ACCELERATION: float = 20.0
@export var H_SPEED_LIMIT: float = 600.0
@export var FRICTION_WEIGHT: float = 0.1
@export var GRAVITY: float = 1200.0
@export var JUMP_FORCE: float = -600.0

var projectile_container

func _ready():
	is_dead = false  # Resetear flag al revivir


func initialize(projectile_container):
	self.projectile_container = projectile_container
	cannon.projectile_container = projectile_container

func _physics_process(delta):
	if get_tree().paused:
		return

	# Cannon rotation
	var mouse_position: Vector2 = get_global_mouse_position()
	cannon.look_at(mouse_position)

	# Cannon fire
	if Input.is_action_just_pressed("fire_cannon"):
		if projectile_container == null:
			projectile_container = get_parent()
			cannon.projectile_container = projectile_container
		cannon.fire()

	# Player horizontal movement
	var h_movement_direction: int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))

	if h_movement_direction != 0:
		velocity.x = clamp(velocity.x + (h_movement_direction * ACCELERATION), -H_SPEED_LIMIT, H_SPEED_LIMIT)
		$Body.play("move")
	else:
		velocity.x = lerp(velocity.x, 0.0, FRICTION_WEIGHT) if abs(velocity.x) > 1 else 0.0
		$Body.stop()
		$Body.frame = 0

	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_FORCE

	# Move the character
	move_and_slide()


var is_dead = false

func die():
	if is_dead:
		return
	is_dead = true
	var game_over_scene = preload("res://ui/GameOver.tscn")
	var ui = game_over_scene.instantiate()
	get_tree().get_current_scene().add_child(ui)
