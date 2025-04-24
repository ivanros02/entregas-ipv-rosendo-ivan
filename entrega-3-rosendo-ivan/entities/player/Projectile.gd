extends AnimatedSprite2D

@onready var lifetime_timer = $LifetimeTimer

@export var VELOCITY: float = 800.0

var direction:Vector2

@onready var area = $Area2D

var source: String = "enemy"  # Por defecto es enemigo


func _ready():
	area.set("owner_node", self)
	area.connect("area_entered", Callable(self, "_on_area_entered"))
	area.connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body is Player and source != "player":
		body.die()
		_remove()
	elif body.is_in_group("walls"):
		_remove()

func initialize(container, spawn_position:Vector2, direction:Vector2):
	self.direction = direction
	global_position = spawn_position

	if source == "player":
		add_to_group("player_projectiles")

	container.add_child(self)

	lifetime_timer.connect("timeout", Callable(self, "_on_lifetime_timer_timeout"))
	lifetime_timer.start()


func _physics_process(delta):
	position += direction * VELOCITY * delta
	var camera := get_viewport().get_camera_2d()
	if camera:
		var screen_rect := Rect2(camera.global_position - get_viewport_rect().size / 2, get_viewport_rect().size)
		if !screen_rect.has_point(global_position):
			_remove()


# Si supero una cantidad de tiempo de vida
func _on_lifetime_timer_timeout():
	_remove()

func _remove():
	queue_free()
