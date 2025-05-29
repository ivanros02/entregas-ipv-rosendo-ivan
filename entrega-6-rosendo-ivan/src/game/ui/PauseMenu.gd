extends Control

## Menú de pausa genérico, abierto utilizando la acción "pause_menu"
## (por default la tecla Esc).

signal return_selected()

onready var options_menu: Control = $OptionsMenu

func _ready() -> void:
	hide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("pause_menu") && !options_menu.visible:
		visible = !visible
		get_tree().paused = visible


func _on_ResumeButton_pressed() -> void:
	hide()
	get_tree().paused = false


func _on_ReturnButton_pressed():
	emit_signal("return_selected")
