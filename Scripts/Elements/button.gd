extends Area2D
class_name ButtonBehaviour

enum ButtonColor { YELLOW , RED }
@export var color_state : ButtonColor = ButtonColor.YELLOW
# Declarar variable exportada Puerta, o al revés en la puerta
var is_active := false
var audio_player : AudioStreamPlayer2D
var button_audio : AudioStream = load("res://Audio/SFX/Menu SFX/Hover-Mouse-SFX.ogg")

func _configure_audio() -> void:
	audio_player = AudioStreamPlayer2D.new()
	add_child(audio_player)
	audio_player.stream = button_audio
	audio_player.bus = "SFX"
	audio_player.pitch_scale = randf_range(.4, .55)

func _ready() -> void:
	_configure_audio()
	if color_state == ButtonColor.YELLOW: $Animation.play("default_yellow")
	elif color_state == ButtonColor.RED: $Animation.play("default_red")

func _on_body_entered(body: Node2D) -> void:
	if body is CandlePlayer and not is_active:
		audio_player.play()
		is_active = true
		print("El jugador presionó el botón")
		if color_state == ButtonColor.YELLOW: $Animation.play("pressed_yellow")
		elif color_state == ButtonColor.RED: $Animation.play("pressed_red")
