extends CanvasLayer

func on_retry_pressed():
	LoadBar.fade_to_scene(LevelRegistry.configs[GameManager.current_level_index -1].level_path)
	queue_free()

func on_go_menu_pressed():
	LoadBar.fade_to_scene("res://Scenes/Levels/main_menu.tscn")
	queue_free()
