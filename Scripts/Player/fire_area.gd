extends Area2D
class_name FireBehaviour

const max_flame := 100.0
var current_flame := max_flame
@export var bar : ProgressBar

func take_damage(amount : float):
	current_flame -= amount
	
	if current_flame < 0:
		current_flame = 0

func _process(_delta: float) -> void:
	if current_flame < max_flame:
		current_flame += 0.5
	
	bar.value = current_flame
