class_name PlayerStateIDLE extends PlayerStateBase

func start() -> void:
	super.start()
	animation_player.play("Fire")

func on_physics_process(delta) -> void:
	player.velocity.x = lerp(player.velocity.x, 0.0, get_deceleration())
	#controlled_node.velocity.x = 0
	
	handle_gravity(delta)
	controlled_node.move_and_slide()

func on_input(event) -> void:
	check_lateral_moving()
	check_jump()
