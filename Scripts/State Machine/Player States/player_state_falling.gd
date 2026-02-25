class_name PlayerStateFalling extends PlayerStateBase

func on_physics_process(delta) -> void:
	super.on_physics_process(delta)
	handle_gravity(delta)
	get_direction()
	
	player.move_and_slide()
	
	# Si debería saltar, ignoramos el piso
	if should_jump():
		consume_jump()
		state_machine.change_to("StateJump")
		return # Salteamos chequeo
	
	if player.is_on_floor(): 
		state_machine.change_to("StateIdle")
