extends Node

@export var turret_scene: PackedScene

func _ready() -> void:
	call_deferred("initialize")

func initialize():
	var visible_rect:Rect2 = get_viewport().get_visible_rect()
	var player = get_tree().get_current_scene().find_child("Player", true, false)

	# Torretas aleatorias
	for i in 2:
		var turret_instance = turret_scene.instantiate()
		var turret_pos:Vector2 = Vector2(
			randf_range(1118, 2000),
			185
		)

		turret_instance.initialize(self, turret_pos, self)
		turret_instance.target = player
		turret_instance.get_node("FireTimer").start()

	# Torretas en posiciones fijas usando Marker2D
	for marker in get_children():
		if marker is Marker2D:
			var turret_instance = turret_scene.instantiate()
			turret_instance.initialize(self, marker.global_position, self)
			turret_instance.target = player
			turret_instance.get_node("FireTimer").start()
