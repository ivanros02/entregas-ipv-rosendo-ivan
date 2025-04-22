extends Sprite2D

@onready var cannon_tip = $CannonTip

@export var projectile_scene: PackedScene

var projectile_container

func fire():
	var direction = cannon_tip.global_position.direction_to(get_global_mouse_position())
	if direction == Vector2.ZERO:
		return
	
	var proj_instance = projectile_scene.instantiate()
	proj_instance.source = "player"
	proj_instance.initialize(projectile_container, cannon_tip.global_position, direction.normalized())
