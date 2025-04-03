extends Sprite2D

@onready var fire_position: Marker2D = $FirePosition

@export var projectile_scene: PackedScene

var projectile_container: Node

func fire():
	var projectile_instance: Projectile = projectile_scene.instantiate()
	projectile_container.add_child(projectile_instance)
	projectile_instance.set_starting_values(
	fire_position.global_position,
	(get_global_mouse_position() - fire_position.global_position).normalized())
	projectile_instance.delete_requested.connect(on_projectile_delete_request)
	
func on_projectile_delete_request(projectile: Projectile):
	projectile_container.remove_child(projectile)
	projectile.queue_free()
