class_name PlayerStateJump extends PlayerStateBase

func start() -> void:
	super.start()
	player.velocity.y = player.JUMP_VELOCITY

func on_physics_process(delta) -> void:
	super.on_physics_process(delta)
	# Si no chequeamos dirección también, no va al costado si se presionan al mismo tiempo
	get_direction()
	
	handle_gravity(delta)
	check_falling()
	
	player.move_and_slide()

func on_input(event) -> void:
	super.on_input(event)
	check_lateral_moving()
