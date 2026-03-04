extends Node # Acceso global GameData

# Aquí podemos ir alterando el array para añadir capas como fecha del record, hora, etc
var current_records : Array[LevelRecord] = []
var _pending_coins : Array[CoinData] = []

const save_path = "user://save_game.res"

func _ready() -> void:
	load_data()

# Se llama desde CoinCollectable al recoger
func register_coin(level_id: int, material: CoinData.CoinMaterial) -> void:
	var coin := CoinData.new()
	coin.set_data(level_id, material)
	_pending_coins.append(coin)

func add_record(level_id : int, new_time : float) -> LevelRecord:
	var new_record = LevelRecord.new()
	new_record.set_data(level_id, new_time)
	
	# Transferimos solo las monedas de este nivel 
	for coin in _pending_coins:
		if coin.level_id == level_id: 
			new_record.coins_collected.append(coin)
	_pending_coins.clear()
	# Calcular estrellas antes de guardar
	var config: LevelConfig = LevelRegistry.get_config(level_id)
	if config: new_record.stars = config.count_stars(new_record)
	# Se agrega a la lista, se elimina el 10mo y se guarda en el disco
	current_records.append(new_record)
	_clean_old_records(level_id)
	_save_to_disk()
	
	return new_record

func search_max_stars(target_level_id: int) -> int:
	var max_stars : int = 0
	var current_level_records : Array[LevelRecord] = []
	# Filtramos records
	for rec in current_records:
		if rec.level_id == target_level_id:
			current_level_records.append(rec)
	# Buscamos máximo de estrellas en lista filtrada
	for rec in current_level_records:
		if rec.stars > max_stars:
			max_stars = rec.stars
	print(max_stars)
	return max_stars

# Al morir, se resetea la lista
func discard_pending_coins() -> void: _pending_coins.clear()

func _clean_old_records(target_level_id : int):
	# Contamos cuántos records hay en este nivel
	var records_of_this_level : Array[LevelRecord] = []
	for rec in current_records:
		if rec.level_id == target_level_id:
			records_of_this_level.append(rec)
	# Borramos al superar 9
	if records_of_this_level.size() > 9:
		# Ordenamos de mayor a menor tiempo y luego eliminamos el primero (mayor tiempo)
		records_of_this_level.sort_custom(
		func(a, b): 
			if a.stars != b.stars: return a.stars < b.stars # Ordena por cantidad de estrellas
			return a.time_record > b.time_record # En caso de misma cantidad, ordena por tiempos
		)
		current_records.erase(records_of_this_level[0])

func save_locale(locale: String) -> void: _save_to_disk(locale)

func _save_to_disk(locale_override: String = ""):
	var save = SaveData.new()
	save.records = current_records
	save.saved_locale_lang = locale_override if locale_override != "" else TranslationServer.get_locale()
	ResourceSaver.save(save, save_path)

func load_data():
	if ResourceLoader.exists(save_path):
		var save = load(save_path)
		
		if save:
			current_records = save.records
			_migrate_stars()
			# Aplicar idioma guardado
			if save.saved_locale_lang != "": TranslationServer.set_locale(save.saved_locale_lang)
			else: TranslationServer.set_locale("en_US")
		else: TranslationServer.set_locale("en_US")

func _migrate_stars() -> void:
	for rec in current_records:
		if rec.stars == 0:
			var config: LevelConfig = LevelRegistry.get_config(rec.level_id)
			if config: rec.stars = config.count_stars(rec)
	_save_to_disk()
