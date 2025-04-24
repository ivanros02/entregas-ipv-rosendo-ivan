extends CanvasLayer

@onready var retry_button = $Panel/Button

func _ready():
	$SoundPlayer.play()
	retry_button.connect("pressed", Callable(self, "_on_retry_pressed"))
	get_tree().paused = true  # Pausar el juego al mostrar Game Over
	process_mode = Node.PROCESS_MODE_ALWAYS  # Asegura que este cartel funcione aunque el juego esté en pausa

func _on_retry_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
