extends AnimationPlayer
class_name CandleAnimations

@export var animated_sprite : AnimatedSprite2D
@export var candle : CharacterBody2D

func _ready() -> void:
	play("Fire")
	animated_sprite.play("Fire")
