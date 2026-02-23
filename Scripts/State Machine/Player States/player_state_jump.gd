class_name PlayerStateJump extends PlayerStateBase

func start() -> void:
	super.start()
	player.velocity.y = player.JUMP_VELOCITY

func on_physics_process(delta) -> void:
	var direction : float = Input.get_axis("izquierda", "derecha")
	
	if direction:
		var acceleration = get_acceleration()
		player.velocity.x = lerp(player.velocity.x, direction * player.SPEED, acceleration)
		# La mecánica del fuego
		player.fire_behaviour. take_damage(1.5)
		if player.fire_behaviour.current_flame <= 0.0: player.fire_behaviour.kill()
	else: 
		var deceleration = get_deceleration()
		player.velocity.x = lerp(player.velocity.x, 0.0, deceleration)
	
	handle_gravity(delta)
	check_falling()
	
	player.move_and_slide()

func on_input(event) -> void:
	check_lateral_moving()
