extends Area2D

@export var speed: float = 400.0
var velocity: Vector2

func _ready():
	$AnimatedSprite2D.play("fly")
	velocity = Vector2.RIGHT.rotated(rotation) * speed

func _process(delta):
	position += velocity * delta

	if not get_viewport_rect().has_point(global_position):
		queue_free()


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("enemy"):
		body.call("die")  
		queue_free()      
