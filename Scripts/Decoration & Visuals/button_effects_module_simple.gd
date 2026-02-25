class_name ButtonEffectsModuleSimple extends Node

@export var ease_type: Tween.EaseType
@export var trans_type: Tween.TransitionType
@export var anim_duration: float = 0.2
@export var scale_amount: Vector2 = Vector2(1.05, 1.05)

@onready var button: Button = get_parent()

var tween: Tween

var hover_player: AudioStreamPlayer2D
var pressed_player
var sfx_hover : AudioStream = preload("res://Audio/SFX/Menu SFX/Hover-Mouse-SFX.ogg")
var sfx_pressed : AudioStream = preload("res://Audio/SFX/Menu SFX/Button-Pressed-SFX.ogg")

func _ready() -> void:
	hover_player = AudioStreamPlayer2D.new()
	pressed_player = AudioStreamPlayer2D.new()
	hover_player.stream = sfx_hover
	pressed_player.stream = sfx_pressed
	add_child(hover_player)
	add_child(pressed_player)
	button.mouse_entered.connect(_on_mouse_hovered.bind(true))
	button.mouse_exited.connect(_on_mouse_hovered.bind(false))
	button.pressed.connect(_on_button_pressed)
	button.pivot_offset_ratio = Vector2(0.5, 0.5)

func _on_button_pressed() -> void:
	pressed_player.play()
	reset_tween()
	tween.tween_property(button, "scale", scale_amount, anim_duration).from(Vector2(0.8, 0.8))

func _on_mouse_hovered(hovered: bool) -> void:
	hover_player.play()
	reset_tween()
	tween.tween_property(button, "scale", 
		scale_amount if hovered else Vector2.ONE, anim_duration)

func reset_tween() -> void:
	if tween: tween.kill()
	tween = create_tween().set_ease(ease_type).set_trans(trans_type).set_parallel(true)
