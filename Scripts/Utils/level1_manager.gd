extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalMusicManager.current_state = GlobalMusicManager.Scene_State.LEVEL1
