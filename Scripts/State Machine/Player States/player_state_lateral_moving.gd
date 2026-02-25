class_name PlayerStateLateralMoving extends PlayerStateBase

@export var fire_behaviour: FireBehaviour

func on_physics_process(delta) -> void:
	super.on_physics_process(delta)
	# Asignamos velocidad x según la velocidad del player
	get_direction()
	
	# Actualizamos animación
	if player.velocity.x > 0: animation_player.play("Right_Moving")
	if player.velocity.x < 0: animation_player.play("Left_Moving")
	
	handle_gravity(delta)
	player.move_and_slide()


func on_input(event) -> void:
	super.on_input(event)
	check_lateral_moving()
	check_jump()
	check_idle()
