extends CanvasLayer

@onready var stars_label = $RichTextLabel
# Implementar lógica de muestra de estrellas al ganar
var stars : int

func _ready() -> void:
	await get_tree().process_frame
	#var entry = 
	var stars_text : String = "★".repeat(stars) + "☆".repeat(5 - stars) 
	
	stars_label.text = stars_text + "\n" + tr("STARS-WIN: %d" % stars)

func on_retry_pressed():
	LoadBar.fade_to_scene(LevelRegistry.configs[GameManager.current_level_index].level_path)
	queue_free()

func on_go_menu_pressed():
	LoadBar.fade_to_scene("res://Scenes/Levels/main_menu.tscn")
	queue_free()
