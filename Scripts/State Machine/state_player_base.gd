class_name PlayerStateBase extends StateGravityBase

@export var animation_player : AnimationPlayer
var player: CandlePlayer

func start(): player = controlled_node

func on_process(delta) -> void:
	# chequeamos vida y ejecutamos Finished que evita las entradas del jugador
	if player.fire_behaviour.current_flame <= 0:
		if state_machine.current_state.name != "StateFinished":
			state_machine.change_to("StateFinished")

func get_acceleration() -> float:
	if player.in_slime: return 0.1
	if player.in_wind: return 0.1
	return 0.85

func get_deceleration() -> float:
	if player.in_slime: return 0.05
	if player.in_wind: return 0.3
	return 0.85

func check_lateral_moving() -> void:
	if Input.is_action_pressed("derecha") or Input.is_action_pressed("izquierda"):
		state_machine.change_to("StateLateralMoving")

func check_jump() -> void:
	if Input.is_action_pressed("arriba") and player.is_on_floor(): state_machine.change_to("StateJump")

func check_idle() -> void:
	if Input.get_axis("izquierda", "derecha") == 0.0: state_machine.change_to("StateIdle")

func check_falling() -> void:
	if player.velocity.y > 0: state_machine.change_to("StateFalling")
