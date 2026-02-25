class_name PlayerStateInWind extends PlayerStateBase


func on_physics_process(delta) -> void:
	super.on_physics_process(delta)
	# Aplicamos movimiento
	var direction : float = Input.get_axis("izquierda", "derecha")
	var target_x : float = player.wind_direction.x + (direction * player.SPEED * 0.4)
	player.velocity.x = lerp(player.velocity.x, target_x, get_acceleration())
	
	if player.wind_direction.y != 0:
		player.velocity.y = lerp(player.velocity.y, player.wind_direction.y, 0.05)
	else: handle_gravity(delta)
	
	if not player.in_wind: state_machine.change_to("StateIdle")
	
	player.move_and_slide()
