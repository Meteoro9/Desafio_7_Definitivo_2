extends CharacterBody2D
class_name CandlePlayer

const SPEED = 300.0
const JUMP_VELOCITY = -530.0
var won : bool = false
@export var fire_behaviour : FireBehaviour
@onready var state_machine : StateMachine = $"State Machine"

#region States
# Slime
var _active_slime_trails : Array[SlimeTrail] = []
var normal_friction := 0.85
var wind_friction : float = 0.30
var in_wind : bool = false
var wind_direction : Vector2 = Vector2.ZERO

var in_slime: bool:
	get: return not _active_slime_trails.is_empty()

var slime_friction: float:
	get:
		if _active_slime_trails.is_empty(): return normal_friction
		return _active_slime_trails.map(func(t): return t.friction_override).min()

func aply_slime_effect(trail: SlimeTrail) -> void:
	if trail not in _active_slime_trails: _active_slime_trails.append(trail)

func remove_slime_effect(trail: SlimeTrail) -> void:
	_active_slime_trails.erase(trail)

# Wind
func enter_wind(direction: Vector2) -> void:
	wind_direction = direction
	in_wind = true

func exit_wind() -> void:
	wind_direction = Vector2.ZERO
	in_wind = false
#endregion
