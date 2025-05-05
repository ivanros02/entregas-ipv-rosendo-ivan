extends Area2D

@export var speed: float = 300.0
var velocity: Vector2

@onready var sprite = $AnimatedSprite2D

func _ready():
	sprite.play("fly")
	velocity = Vector2.RIGHT.rotated(rotation) * speed

func _process(delta):
	position += velocity * delta
	if not get_viewport_rect().has_point(global_position):
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if body.has_method("die"):
			body.die()
		else:
			body.queue_free()
		queue_free()
