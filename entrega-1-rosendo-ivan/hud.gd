extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()

	# 🔹 Ocultar automáticamente "Get Ready" después de 1.5 segundos
	if text == "Get Ready":
		await get_tree().create_timer(1.5).timeout
		$Message.hide()
	elif text == "Game Over":
		# 🔹 Si es "Game Over", mostrar "Dodge the Creeps!" después de esperar
		await get_tree().create_timer(1.5).timeout
		$Message.text = "Dodge the Creeps!"
		$Message.show()

		# 🔹 Luego de otro segundo, mostrar el botón Start
		await get_tree().create_timer(1.0).timeout
		$StartButton.show()

func show_game_over():
	show_message("Game Over")

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
