extends Area2D
class_name WindArea

enum Direction { LEFT, RIGHT, DOWN, UP }

@export var direction_to : Direction = Direction.UP
var damage := 50.0
var player_inside : CandlePlayer = null
var characters : Array[CharacterBody2D] = []
var _push_lateral_speed : float = 1000.0
var _push_vertical_speed : float = 1000.0
@export var _transition_type : Tween.TransitionType = Tween.TRANS_ELASTIC

func direction_vector() -> Vector2:
	match direction_to:
		Direction.LEFT: return Vector2.LEFT * _push_lateral_speed
		Direction.RIGHT: return Vector2.RIGHT * _push_lateral_speed
		Direction.DOWN: return Vector2.DOWN * _push_vertical_speed
		Direction.UP: return Vector2.UP * _push_vertical_speed
	return Vector2.ZERO

func _on_body_entered(body: Node2D) -> void:
	if body is CandlePlayer:
		body.enter_wind(direction_vector())
		player_inside = body
		body.state_machine.change_to("StateInWind")
		print("El jugador entró al viento")
		body.in_wind = true

func _on_body_exited(body: Node2D) -> void:
	if body == player_inside:
		body.exit_wind()
		body.state_machine.change_to("StateIdle")
		player_inside = null
		print("El jugador salió del viento")
		body.in_wind = false

func _process(delta: float) -> void:
	if player_inside:
		player_inside.fire_behaviour.take_damage(damage * delta)

func _on_timer_timeout() -> void:
	queue_free()
