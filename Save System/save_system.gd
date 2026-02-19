extends Resource
class_name SaveData

@export var records : Array[LevelRecord] = []
@export var saved_locale_lang: String = ""

func save_times(times_to_save : Array):
	records = times_to_save
	

func load_times() -> Array: 
	return records
