extends Node
class_name LevelSummaryMenu

# Agregar acá los niveles para poder seleccionarlos.
# Level_0 = Sample_Level, no mostrarlo en versión final
enum LevelSelected { LEVEL_0, LEVEL_1, LEVEL_2, LEVEL_3, LEVEL_4, LEVEL_5,
LEVEL_6, LEVEL_7, LEVEL_8 } 
@export var level_id : LevelSelected = LevelSelected.LEVEL_1

#@export var play_requirement: LevelPlayRequirement

# Info procesada para mostrar en pantalla
var processed_records: Array[Dictionary] = []

func _ready() -> void:
	var raw_list: Array[LevelRecord] = GameData.current_records
	var levels_list: Array[LevelRecord] = _filter_level_records(raw_list)
	processed_records = _build_display_data(levels_list)

# Filtramos records solo para el nivel correspondiente actual
func _filter_level_records(raw: Array[LevelRecord]) -> Array[LevelRecord]:
	var result: Array[LevelRecord]
	for rec in raw:
		if rec.level_id == level_id:
			result.append(rec)
	result.reverse()
	return result

# Guardamos el diccionario que pasará la info para mostrarse en pantalla
func _build_display_data(records: Array[LevelRecord]) -> Array[Dictionary]:
	var result: Array[Dictionary] = []
	for rec in records:
		result.append({
			"time": "%.2f" % rec.time_record,
			"date": rec.get_date_string(),
			"hour": rec.get_hour_string(),
			"stars": rec.stars #stars
		})
	return result
