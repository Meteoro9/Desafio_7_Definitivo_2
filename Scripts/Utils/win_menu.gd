extends CanvasLayer

@onready var stars_label = $RichTextLabel
# Implementar lógica de muestra de estrellas al ganar
var stars : int

func _ready() -> void:
	await get_tree().process_frame
	var stars_text : String = "[wave][title-effect]" + "★".repeat(stars) + "☆".repeat(5 - stars) + "[/title-effect][/wave]"
	
	stars_label.text = stars_text

func on_retry_pressed():
	LoadBar.fade_to_scene(LevelRegistry.configs[GameManager.current_level_index].level_path)
	queue_free()

func on_go_menu_pressed():
	LoadBar.fade_to_scene("res://Scenes/Levels/main_menu.tscn")
	queue_free()
