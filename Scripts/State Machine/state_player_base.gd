class_name PlayerStateBase extends StateGravityBase

@export var animation_player : AnimationPlayer
var player: CandlePlayer

func start(): player = controlled_node

func get_friction() -> float:
	if player.in_slime: return player.slime_friction
	if player.in_wind: return player.wind_friction
	return player.normal_friction

func check_lateral_moving() -> void:
	if Input.is_action_pressed("derecha") or Input.is_action_pressed("izquierda"):
		state_machine.change_to("StateLateralMoving")

func check_jump() -> void:
	if Input.is_action_pressed("arriba") and player.is_on_floor():
		state_machine.change_to("StateJump")

func check_idle() -> void:
	if Input.get_axis("izquierda", "derecha") == 0.0:
		state_machine.change_to("StateIdle")

func check_falling() -> void:
	if player.velocity.y > 0: 
		state_machine.change_to("StateFalling")
