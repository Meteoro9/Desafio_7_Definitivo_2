extends CanvasLayer

@onready var stars_label = $RichTextLabel
# Implementar lógica de muestra de estrellas al ganar
var stars : int = 0

func _ready() -> void:
	#stars_label.text = 
	pass

func on_retry_pressed():
	LoadBar.fade_to_scene(LevelRegistry.configs[GameManager.current_level_index].level_path)
	queue_free()

func on_go_menu_pressed():
	LoadBar.fade_to_scene("res://Scenes/Levels/main_menu.tscn")
	queue_free()
