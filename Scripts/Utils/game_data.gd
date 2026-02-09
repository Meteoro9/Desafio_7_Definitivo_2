extends Node
class_name GamePersistentData

# Aquí podemos ir alterando el array para añadir capas como fecha del record, hora, etc
var records : Array[float] = []

func _ready() -> void:
	load_data()

<<<<<<< HEAD

func add_time(level_id: String, new_time: float) -> void:
	var record := RecordData.new()
	record.time = new_time

	var datetime := Time.get_datetime_dict_from_system()
	record.day = "%04d-%02d-%02d" % [
		datetime.year,
		datetime.month,
		datetime.day
	]
	record.hour = "%02d:%02d:%02d" % [
		datetime.hour,
		datetime.minute,
		datetime.second
	]

	var level_data := _get_or_create_level(level_id)
	level_data.records.append(record)

	if level_data.records.size() > MAX_RECORDS_PER_LEVEL:
		level_data.records.pop_front()

	save_data()


func get_records(level_id: String) -> Array[RecordData]:
	for level_data in data.levels:
		if level_data.level_id == level_id:
			return level_data.records

	return [] as Array[RecordData]  # ← Array tipado explícito


func _get_or_create_level(level_id: String) -> LevelData:
	for level_data in data.levels:
		if level_data.level_id == level_id:
			return level_data

	var new_level := LevelData.new()
	new_level.level_id = level_id
	data.levels.append(new_level)
	return new_level


func save_data() -> void:
	ResourceSaver.save(data, SAVE_PATH)


func load_data() -> void:
	if ResourceLoader.exists(SAVE_PATH):
		data = load(SAVE_PATH) as SaveData
		if data == null:
			data = SaveData.new()
	else:
		data = SaveData.new()
=======
func add_time(new_time : float):
	records.append(new_time)
	
	if records.size() > 9:
		records.pop_front()
	
	var save = SaveData.new()
	save.save_times(records)
	ResourceSaver.save(save, "user://save.res")

func load_data():
	if ResourceLoader.exists("user://save.tres"):
		var save = load("user://save.res")
		
		if save:
			records = save.records
>>>>>>> parent of 076d508 (Nueva implementación guardado NO FUNCIONAL)
