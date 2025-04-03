extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.set_projectile_container(self)
	$Turret.set_player($Player, self)
	$Turret2.set_player($Player, self)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
