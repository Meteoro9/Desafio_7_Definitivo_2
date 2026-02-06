extends CanvasLayer


func on_retry_pressed():
	# Implementar guardado de tiempo y reinicio de escena
	
	pass

func on_go_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/main_menu.tscn")
	queue_free()
