class_name LevelRegistryAutoload extends Node

@export var configs : Array[LevelConfig] = []

func get_config(_level_id: int) -> LevelConfig:
	for config in configs: 
		if config.level_id == _level_id:
			return config
	push_warning("LevelRegistry: no config found for level %d" % _level_id)
	return null
