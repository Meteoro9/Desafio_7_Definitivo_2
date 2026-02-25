class_name JumpBehaviourModule extends Node

var player

var coyote_time : float = 0.2
var coyote_timer : float = 0.0
var input_buffer_time : float = 0.2
var input_buffer_timer : float = 0.0

var jump_buffered : bool = false
var jump_available : bool = false

func _ready() -> void:
	await get_tree().process_frame
	player = self.owner

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


func should_jump() -> bool:
	if not jump_buffered: return false
	if player.is_on_floor() or coyote_timer < coyote_time: return true
	return false

func consume_jump():
	jump_buffered = false
	input_buffer_timer = 0.0
	coyote_timer = coyote_time
