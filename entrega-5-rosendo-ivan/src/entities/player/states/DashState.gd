extends AbstractState

# Tiempo que durará el dash
const DASH_DURATION := 0.2
# Velocidad del dash
const DASH_SPEED := 1000.0

var dash_timer := 0.0
var dash_direction := 0

func enter() -> void:
	dash_timer = DASH_DURATION
	dash_direction = sign(character.move_direction)
	if dash_direction == 0:
		dash_direction = character.get_facing_direction() # por si no se está moviendo pero queremos que dashée hacia donde mira
	character._play_animation("dash")
	character.velocity.x = dash_direction * DASH_SPEED

func update(delta: float) -> void:
	dash_timer -= delta

	# Mantenemos la velocidad constante durante el dash
	character.velocity.x = dash_direction * DASH_SPEED
	character._apply_movement()  # sin fricción

	if dash_timer <= 0.0:
		emit_signal("finished", "idle" if character.move_direction == 0 else "walk")

func handle_input(event: InputEvent) -> void:
	pass  # durante el dash, no respondemos a input

func handle_event(event: String, value = null) -> void:
	match event:
		"hit":
			character._handle_hit(value)
			if character.dead:
				emit_signal("finished", "dead")

func exit() -> void:
	# Restablecer velocidad si es necesario
	character.velocity.x = 0
