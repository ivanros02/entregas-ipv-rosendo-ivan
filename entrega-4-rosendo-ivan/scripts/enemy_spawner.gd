extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_area: Rect2 = Rect2(100, 100, 800, 400) # área de aparición aleatoria
@export var total_to_spawn: int = 5

func _ready():
	for i in total_to_spawn:
		spawn_enemy()

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	var rand_x = randi_range(spawn_area.position.x, spawn_area.position.x + spawn_area.size.x)
	var rand_y = randi_range(spawn_area.position.y, spawn_area.position.y + spawn_area.size.y)
	enemy.position = Vector2(rand_x, rand_y)
	get_parent().add_child(enemy)
