class_name PlayerStateFalling extends PlayerStateBase

func on_physics_process(delta) -> void:
	handle_gravity(delta)
	player.move_and_slide()
	
	if player.is_on_floor(): state_machine.change_to("StateIdle")
