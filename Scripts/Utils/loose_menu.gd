extends CanvasLayer

func on_retry_pressed():
	LoadBar.fade_to_scene("res://Scenes/Levels/sample_level.tscn")
	queue_free()

func on_go_menu_pressed():
	LoadBar.fade_to_scene("res://Scenes/Levels/main_menu.tscn")
	queue_free()
