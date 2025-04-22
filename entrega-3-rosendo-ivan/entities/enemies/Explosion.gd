extends AnimatedSprite2D

func _ready():
	play("explosion")

func _on_animation_finished():
	queue_free()
