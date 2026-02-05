extends Control
class_name MainMenu

@onready var label = $Label

func _ready() -> void:
	var final_text = "Tus tiempos: \n"
	
	var record_list = GameData.records
	
	if record_list.is_empty():
		final_text += "(Aún no se registró ningún tiempo)"
	else:
		for record in record_list:
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
	
	pass # Replace with function body.
