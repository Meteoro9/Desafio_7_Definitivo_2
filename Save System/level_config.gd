class_name LevelConfig extends Resource

@export var level_id: int
@export var level_path: String

@export var gold_coins_limit: int = 0
@export var silver_coins_limit: int = 0
@export var bronze_coins_limit: int = 0

@export var time_star_1: float = 30.0
@export var time_star_2: float = 25.0

func count_stars(rec: LevelRecord) -> int:
	var stars := 0
	# Filtramos según coleccionables del nivel
	if gold_coins_limit > 0 and rec.get_coins_by_material(CoinData.CoinMaterial.GOLD) >= gold_coins_limit:
		stars += 1
	if silver_coins_limit > 0 and rec.get_coins_by_material(CoinData.CoinMaterial.SILVER) >= silver_coins_limit:
		stars += 1
	if bronze_coins_limit > 0 and rec.get_coins_by_material(CoinData.CoinMaterial.BRONZE) >= bronze_coins_limit:
		stars += 1
	# Filtramos según tiempos necesarios
	if rec.time_record < time_star_1:
		stars += 1
	if rec.time_record < time_star_2:
		stars += 1
	
	return stars
