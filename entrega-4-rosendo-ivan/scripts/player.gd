extends CharacterBody2D

@export var speed: float = 200.0
@export var jump_velocity: float = -400.0
var alive = true
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var cannon: Sprite2D = $Cannon
@onready var muzzle: Marker2D = $Cannon/Muzzle

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
	if not alive:
		return
	cannon.look_at(get_global_mouse_position())

func _physics_process(delta):
	if not alive:
		return
	
	var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * speed

	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = jump_velocity

	move_and_slide()

	if direction != 0:
		sprite.flip_h = direction < 0
		cannon.position.x = -abs(cannon.position.x) if sprite.flip_h else abs(cannon.position.x)

	if not is_on_floor():
		sprite.play("dash")
	elif direction != 0:
		sprite.play("walk")
	else:
		sprite.play("idle")


	# Disparo
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	if not alive:
		return
	var bullet = preload("res://scenes/bullet.tscn").instantiate()
	bullet.global_position = muzzle.global_position
	
	# Calcular dirección al mouse
	var direction = (get_global_mouse_position() - muzzle.global_position).normalized()
	bullet.velocity = direction * bullet.speed  # Pasamos la dirección ya calculada
	get_tree().root.add_child(bullet)

func die():
	if not alive:
		return
	alive = false
	sprite.play("death")
	await sprite.animation_finished
	queue_free()
