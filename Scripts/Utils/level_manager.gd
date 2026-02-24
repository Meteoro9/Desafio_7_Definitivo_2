extends Node
class_name LevelManager

@export var level_id: int = 0
@export var gold_coins_limit : int = 0
@export var silver_coins_limit : int = 0
@export var bronze_coins_limit : int = 0

# Tiempos necesarios para las estrellas dadas por tiempo
@export var time_star_1: float = 30.0
@export var time_star_2: float = 25.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalMusicManager.current_state = GlobalMusicManager.Scene_State.LEVEL1
	GameManager.current_level_index = level_id
