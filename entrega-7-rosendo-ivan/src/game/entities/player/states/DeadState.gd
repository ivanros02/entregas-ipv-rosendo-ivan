extends AbstractState


## Al ser un estado de finalización (es decir, no se sale
## a ningun otro estado), vamos a procesar todo lo necesario
## en el enter
func enter() -> void:
	print("🔴 Entrando al estado Dead")
	
	# Reproducir sonido de muerte con AudioStreamPlayer temporal
	if character.death_sfx:
		var death_audio = AudioStreamPlayer.new()
		character.add_child(death_audio)
		death_audio.stream = character.death_sfx
		death_audio.play()
		print("🔊 Reproduciendo sonido de muerte")
		
		# Configurar para que se elimine automáticamente cuando termine
		death_audio.connect("finished", death_audio, "queue_free")
	
	# Efectos visuales y señales
	character.emit_signal("dead")
	character._play_animation("die")


## Y en update solo manejamos la fricción y movimiento
## para que no sea un cubo de hielo al morir
func update(delta: float) -> void:
	character._handle_deacceleration(delta)
	character._apply_movement()


## Para este punto solo hay una animación reproduciendose
## por lo que podemos extraer el llamado a _remove desde la
## animación a esta función
func _on_animation_finished(anim_name:String) -> void:
	character._remove()
