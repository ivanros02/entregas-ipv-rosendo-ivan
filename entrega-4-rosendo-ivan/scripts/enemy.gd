extends CharacterBody2D

@export var shoot_interval = 2.0
@export var bullet_scene: PackedScene
@onready var muzzle = $Muzzle
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var player_detected = false
var shoot_timer = 0.0
var alive = true

func _ready():
	sprite.play("idle")

func _process(delta):
	if not alive:
		return

	if player_detected:
		shoot_timer -= delta
		if shoot_timer <= 0:
			shoot()
			shoot_timer = shoot_interval


func shoot():
	

	if not bullet_scene or not muzzle:
		return

	var bullet = bullet_scene.instantiate()
	bullet.global_position = muzzle.global_position

	var player = get_tree().get_first_node_in_group("player")
	if player:
		var direction = (player.global_position - bullet.global_position).normalized()
		bullet.velocity = direction * bullet.speed
		bullet.rotation = direction.angle()

	get_tree().current_scene.add_child(bullet)


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_detected = true

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_detected = false

func _on_area_entered(area: Area2D) -> void:
	if area.name.begins_with("Bullet"):
		die()
		area.queue_free()

func _on_enemy_area_entered(area: Area2D) -> void:
	_on_area_entered(area)

func die():
	alive = false
	sprite.play("death")
	await sprite.animation_finished
	queue_free()
