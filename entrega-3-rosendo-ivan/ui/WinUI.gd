extends CanvasLayer

@onready var retry_button = $Panel/Button

func _ready():
	retry_button.connect("pressed", Callable(self, "_on_retry_pressed"))
	get_tree().paused = true
	process_mode = Node.PROCESS_MODE_ALWAYS


func _on_retry_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
