class_name PlayerStateInWater extends PlayerStateBase

var water_gravity : float

func start():
	super.start()
	water_gravity = gravity / 2

func handle_gravity(delta):
	controlled_node.velocity.y += water_gravity * delta

func on_physics_process(delta):
	get_direction()
	player.velocity.x *= player.WATER_MULTIPLIER
	handle_gravity(delta)
	check_jump()
	player.move_and_slide()

func check_jump() -> void:
	if Input.is_action_pressed("arriba") and player.is_on_floor():
		state_machine.change_to("StateJump")
		player.velocity.y *= player.WATER_MULTIPLIER
		
