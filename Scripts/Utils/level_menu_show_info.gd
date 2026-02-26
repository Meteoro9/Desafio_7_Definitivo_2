extends Control
class_name LevelShowInfo

@export var times_record_label : Label
@export var day_record_label : Label
@export var hour_record_label : Label
@export var stars_record_label : Label
@export var times_no_records_label : Label
@export var level_index_label : RichTextLabel
@export var panel_container: PanelContainer
@export var play_button : Button
@export var cant_play_label : RichTextLabel

@export var level_info_array_ordered : Array[LevelSummaryMenu]
var current_level_index : int = GameManager.current_showed_index
@export var h_box_container : HBoxContainer
@export var animation : AnimationPlayer

var languages: Array[String] = ["en_US", "es_AR", "pt_BR", "zh_CN", "ja_JP", "ru_RU", "gn_PY", "fr_FR", "hi_IN"]
var current_lang := "en_US"

func _ready() -> void:
	animation.play("init")
	await animation.animation_finished
	#await get_tree().create_timer(1.0).timeout
	show_info(level_info_array_ordered[0])

#region Update Info
func show_info(summary: LevelSummaryMenu) -> void:
	current_lang = TranslationServer.get_locale() # Actualizamos idioma
	var current_lang_index = languages.find(current_lang)
	if current_lang_index == -1: current_lang_index = 0
	# Mostramos en pantalla qué nivel es
	level_index_label.text = tr("LEVEL-TITLE") % (current_level_index + 1)
	# Creamos variables para actualizar el texto
	var times_text : String = ""
	var day_text : String = ""
	var hour_text : String = ""
	var stars_text : String = ""
	# Actualizamos variables de texto
	if summary.processed_records.is_empty():
		times_no_records_label.text = tr("NO-RECORDS")
	else:
		times_no_records_label.text = ""
		for entry in summary.processed_records:
			times_text += "*" + entry["time"] + "\n"
			day_text += entry["date"] + "\n"
			hour_text += entry["hour"] + "\n"
			stars_text += "★".repeat(entry["stars"]) + "☆".repeat(5 - entry["stars"]) + "\n"
	# Asignamos nuevo texto a labels
	times_record_label.text = times_text
	day_record_label.text = day_text
	hour_record_label.text = hour_text
	stars_record_label.text = stars_text
	# Revisamos si el jugador puede jugar el nivel
	#_update_play_availability(summary)
	placing_no_records_label()



# Método a revisar NO FUNCIONA
func _update_play_availability(summary: LevelSummaryMenu) -> void:
	var requirement : LevelPlayRequirement = summary.play_requirement
	# Sin requisito se puede jugar
	if requirement == null or not requirement.has_requirement:
		play_button.disabled = false
		play_button.text = tr("PLAY")
		return
	var prev_index : int = current_level_index -1
	var allowed : bool = false
	
	if prev_index >= 0 and prev_index < level_info_array_ordered.size():
		var prev_summary: LevelSummaryMenu = level_info_array_ordered[prev_index]
		allowed = requirement.can_play(prev_summary)
	else: allowed = true # Si es el primer nivel, siempre se permite jugar
	
	
	cant_play_label.visible = true
	play_button.disabled = not allowed
	play_button.text = tr("PLAY") if allowed else tr("[color=red][wave]CANNOT-PLAY")
#endregion

#region Animations
func show_level_info():
	placing_no_records_label() # Volvemos a centrar si volvemos a mostrar (por si cambió el idioma)
	animation.play("appear")
	await animation.animation_finished
	animation.play("default")

func hide_level_info():
	animation.play("desappear")
	await animation.animation_finished
	visible = false
	var animation_menu = get_parent().get_node("AnimationPlayer")
	animation_menu.play("show_menu")

func placing_no_records_label():
	await get_tree().process_frame
	var panel_global_pos = panel_container.global_position
	var panel_size = panel_container.size
	var label_size = times_no_records_label.size
	
	var offset_x : float = 100.0
	var offset_y : float = 0.0
	
	var new_pos = Vector2(
		panel_global_pos.x + offset_x,
		panel_global_pos.y + (panel_size.y - label_size.y) / 2.0 + offset_y
	)
	var tween = create_tween()
	tween.tween_property(times_no_records_label, "global_position", new_pos, 0.2).set_trans(Tween.TRANS_BOUNCE)
#endregion

#region Buttons!!!
func _on_button_next_pressed():
	if (current_level_index + 1) < level_info_array_ordered.size():
		current_level_index += 1
		show_info(level_info_array_ordered[current_level_index])
		GameManager.current_showed_index = current_level_index

func _on_button_previous_pressed():
	if not (current_level_index -1) < 0: # Este es debug
		current_level_index -= 1
		show_info(level_info_array_ordered[current_level_index])
		GameManager.current_showed_index = current_level_index

func _on_button_play_pressed():
	if not play_button.disabled: # Doble chequeo de seguridad
		LoadBar.fade_to_scene(LevelRegistry.configs[current_level_index].level_path)

func _on_button_prev_menu_pressed():
	hide_level_info()
#endregion
