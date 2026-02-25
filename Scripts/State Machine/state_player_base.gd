class_name PlayerStateBase extends StateGravityBase

@export var animation_player : AnimationPlayer
var player: CandlePlayer

func start(): player = controlled_node

var coyote_time : float = 0.2
var coyote_timer : float = 0.0
var input_buffer_time : float = 0.2
var input_buffer_timer : float = 0.0

var jump_buffered : bool = false
var jump_available : bool = false

func coyote_time_behaviour(delta) -> void:
	if player.is_on_floor(): coyote_timer = 0.0
	else: coyote_timer += delta

func input_buffer_behaviour(delta) -> void:
	if jump_buffered:
		input_buffer_timer += delta
		if input_buffer_timer > input_buffer_time:
			jump_buffered = false
			input_buffer_timer = 0.0
			print("Salto por buffer inhabilitado")

func on_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("arriba"):
		jump_buffered = true
		input_buffer_timer = 0.0

func should_jump() -> bool:
	if not jump_buffered: return false
	if player.is_on_floor() or coyote_timer < coyote_time: return true
	return false

func consume_jump():
	jump_buffered = false
	input_buffer_timer = 0.0
	coyote_timer = coyote_time


func on_process(delta) -> void:
	# chequeamos vida y ejecutamos Finished que evita las entradas del jugador
	if player.fire_behaviour.current_flame <= 0:
		if state_machine.current_state.name != "StateFinished":
			state_machine.change_to("StateFinished")

func on_physics_process(delta) -> void:
	input_buffer_behaviour(delta)
	coyote_time_behaviour(delta)

#region Helper Methods
func get_acceleration() -> float:
	if player.in_slime: return 0.1
	if player.in_wind: return 0.1
	return 0.85

func get_deceleration() -> float:
	if player.in_slime: return 0.05
	if player.in_wind: return 0.3
	return 0.85

func get_direction() -> void:
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
#endregion
#region Checking Changes
func check_lateral_moving() -> void:
	if Input.is_action_pressed("derecha") or Input.is_action_pressed("izquierda"):
		state_machine.change_to("StateLateralMoving")

func check_jump() -> void:
	if should_jump(): 
		consume_jump()
		state_machine.change_to("StateJump")

func check_idle() -> void:
	if Input.get_axis("izquierda", "derecha") == 0.0: state_machine.change_to("StateIdle")

func check_falling() -> void:
	if player.velocity.y > 0: state_machine.change_to("StateFalling")



#endregion
