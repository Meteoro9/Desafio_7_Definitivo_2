extends Node
class_name LevelPlayRequirement

@export var min_stars_required: int = 3 # Requisito alto
@export var has_requirement: bool = true

func can_play(previous_summary: LevelSummaryMenu) -> bool:
	# Filtramos condiciones obligatorias
	if not has_requirement: return true # Si el nivel no tiene requisitos -> se puede jugar
	if previous_summary == null: return true # no se xd
	if previous_summary.processed_records.is_empty(): return false # Si no hay lista de records anteriores -> no se puede jugar
	
	var max_stars: int = 0
	for entry in previous_summary.processed_records:
		if entry["stars"] > max_stars: max_stars = entry["stars"]
	
	return max_stars >= min_stars_required
	
