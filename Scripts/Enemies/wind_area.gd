extends Area2D
class_name WindArea

enum Direction { LEFT, RIGHT, DOWN, UP }

@export var direction_to : Direction = Direction.UP
var damage := 50.0
var player_inside : CandlePlayer = null
var characters : Array[CharacterBody2D] = []
var _push_lateral_speed : float = 1000.0
var _push_vertical_speed : float = 250.0
@export var _transition_type : Tween.TransitionType = Tween.TRANS_ELASTIC

func direction_vector() -> Vector2:
	match direction_to:
		Direction.LEFT: return Vector2.LEFT * _push_lateral_speed
		Direction.RIGHT: return Vector2.RIGHT * _push_lateral_speed
		Direction.DOWN: return Vector2.DOWN * _push_vertical_speed
		Direction.UP: return Vector2.UP * _push_vertical_speed
	return Vector2.ZERO

func _on_body_entered(body: Node2D) -> void:
	characters.append(body)
	if body is CandlePlayer:
		player_inside = body
		print("El jugador entró al viento")
		body.in_wind = true
	var tween = create_tween()
	tween.tween_property(body, "velocity", direction_vector(), 1.0).set_trans(_transition_type)

func _on_body_exited(body: Node2D) -> void:
	characters.erase(body)
	if body == player_inside:
		player_inside = null
		print("El jugador salió del viento")
		body.in_wind = false
	var tween = create_tween()
	tween.tween_property(body, "velocity", Vector2.ZERO, 1.0).set_trans(_transition_type)

func _process(delta: float) -> void:
	if player_inside:
		var fire = player_inside.get_node("FireArea")
		if fire:
			fire.take_damage(damage * delta)

func _on_timer_timeout() -> void:
	queue_free()
