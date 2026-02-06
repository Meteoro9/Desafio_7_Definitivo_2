extends Control
class_name MainMenu

@onready var label = $Label
var languages: Array[String] = ["en", "es"]
var next_language_index := 1

func _ready() -> void:
	var final_text = "Tus tiempos: \n"
	
	var record_list = GameData.records
	
	if record_list.is_empty():
		final_text += "(Aún no se registró ningún tiempo)"
	else:
		# Duplicamos el array y lo reordenamos al revés, el último queda arriba
		var splash_record_list = record_list.duplicate()
		splash_record_list.reverse()
		for record in splash_record_list:
			# Creamos un string formateado
			var time_formatted = "%.2f" % record
			# Lo añadimos a el string final
			final_text += "* " + time_formatted + "\n"
	
	# Actualizamos label
	label.text = final_text
	
	# Cambiar estado de la música:
	await get_tree().process_frame # Esperamos el primer frame
	GlobalMusicManager.current_state = GlobalMusicManager.Scene_State.MENU


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/sample_level.tscn")

func on_language_pressed():
	change_language(languages[next_language_index])
	next_language_index = (next_language_index + 1) % languages.size()

func change_language(lang: String) -> void:
	TranslationServer.set_locale(lang)
