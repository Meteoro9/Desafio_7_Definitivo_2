class_name PlayerStateJump extends PlayerStateBase

func start() -> void:
	super.start()
	player.velocity.y = player.JUMP_VELOCITY

func on_physics_process(delta) -> void:
	handle_gravity(delta)
	check_falling()
	
	player.move_and_slide()

func on_input(event) -> void:
	check_lateral_moving()
