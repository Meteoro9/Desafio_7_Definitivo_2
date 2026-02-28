extends CanvasLayer


# Implementar lógica de muestra de estrellas al ganar
var stars : int
var record : LevelRecord
@export var stars_label : RichTextLabel
@export var time1_label : RichTextLabel
@export var time2_label : RichTextLabel 
@export var bronze_label : RichTextLabel
@export var silver_label : RichTextLabel
@export var gold_label : RichTextLabel
var title_effect_tag : String = "[title-effect]"
var red_tag: String = "[color=red]"

func _ready() -> void:
	await get_tree().process_frame
	var stars_text : String = "[wave][title-effect]" + "★".repeat(stars) + "☆".repeat(5 - stars) + "[/title-effect][/wave]"
	
	stars_label.text = stars_text
	get_level_info()

func get_level_info() -> void:
	var config = LevelRegistry.get_config(record.level_id)
	time1_label.text = evaluate_time(record.time_record, config.time_star_1)
	time2_label.text = evaluate_time(record.time_record, config.time_star_2)
	bronze_label.text = evaluate_coins(record.get_coins_by_material(CoinData.CoinMaterial.BRONZE),
		config.bronze_coins_limit)
	silver_label.text = evaluate_coins(record.get_coins_by_material(CoinData.CoinMaterial.SILVER),
		config.silver_coins_limit)
	gold_label.text = evaluate_coins(record.get_coins_by_material(CoinData.CoinMaterial.GOLD),
		config.gold_coins_limit)

func evaluate_coins(coins_collected: int, coins_to_reach: int) -> String:
	var evaluation : String = ""
	var coins_reached : String = str(coins_collected) + "/" + str(coins_to_reach)
	if coins_collected == coins_to_reach:
		evaluation += title_effect_tag + coins_reached + " = ★" 
	else: evaluation += red_tag + coins_reached + " = ☆"
	return evaluation

# Helper para mostrar evaluación de estrellas de tiempo
func evaluate_time(time_to_evaluate: float, time_to_reach: float) -> String:
	var evaluation : String = ""
	var time : String = "%.2f" % time_to_evaluate
	if time_to_evaluate <= time_to_reach:
		evaluation += title_effect_tag + str(time_to_reach) + " > " + time + " = ★"
	else: 
		evaluation += red_tag + str(time_to_reach) + " < " + time + " = ☆"
	return evaluation

func on_retry_pressed():
	LoadBar.fade_to_scene(LevelRegistry.configs[GameManager.current_level_index -1].level_path)
	queue_free()

func on_go_menu_pressed():
	LoadBar.fade_to_scene("res://Scenes/Levels/main_menu.tscn")
	queue_free()
