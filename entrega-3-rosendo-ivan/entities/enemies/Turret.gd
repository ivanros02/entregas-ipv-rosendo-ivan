extends AnimatedSprite2D

@onready var fire_position = $FirePosition
@onready var fire_timer = $FireTimer

@export var projectile_scene: PackedScene

var projectile_container

var target:Node2D

func _ready():
	add_to_group("turrets")
	fire_timer.connect("timeout", Callable(self, "fire_at_player"))
	$HitboxArea.connect("area_entered", Callable(self, "_on_area_entered"))
	play("fly")

func initialize(container, turret_pos, projectile_container):
	container.add_child(self)
	global_position = turret_pos
	self.projectile_container = projectile_container



func fire_at_player():
	if !is_instance_valid(target) or projectile_scene == null:
		return

	var direction_to_target = fire_position.global_position.direction_to(target.global_position)
	if direction_to_target == Vector2.ZERO:
		return

	var proj_instance = projectile_scene.instantiate()
	if proj_instance == null:
		push_error("🚨 instantiate() devolvió null. Verificá que el PackedScene esté bien.")
		return

	proj_instance.initialize(projectile_container, fire_position.global_position, direction_to_target)



func _on_detection_area_body_entered(body: Node2D) -> void:
	if target == null:
		target = body
		fire_timer.start()


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body == target:
		target = null
		fire_timer.stop()


func _on_area_entered(area):
	var projectile = area.get_parent()
	if projectile != null and projectile.is_in_group("player_projectiles"):
		# Mostrar la explosión externa
		var explosion = preload("res://entities/enemies/Explosion.tscn").instantiate()
		explosion.global_position = global_position
		get_tree().get_current_scene().add_child(explosion)

		# Detener disparo y colisión
		$FireTimer.stop()
		set_deferred("monitorable", false)

		queue_free()  # Eliminar la torreta

		# Chequear si era la última
		var scene = get_tree().get_current_scene()
		if scene.get_tree().get_nodes_in_group("turrets").size() <= 1:
			var win_ui = preload("res://ui/WinUI.tscn").instantiate()
			scene.add_child(win_ui)
