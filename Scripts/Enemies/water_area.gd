extends Area2D
class_name WaterArea

var damage : float = 50.0
var player_inside : CandlePlayer = null
@onready var audio_player : AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	area_entered.connect(_on_body_entered)

func play_audio() -> void:
	var pitch = randf_range(0.7,1.3)
	audio_player.pitch_scale = pitch
	audio_player.play()

func _on_body_entered(body: Node2D) -> void:
	if body is CandlePlayer:
		player_inside = body
		body.state_machine.change_to("StateInWater")
		print("Entro el jugador al agua")
		play_audio()
	if body is FireBehaviour: body.kill()

func _on_body_exited(body: Node2D) -> void:
	if body == player_inside:
		body.state_machine.change_to("StateLateralMoving")
		player_inside = null
		print("El jugador salió del agua")

func _process(delta: float) -> void:
	if player_inside:
		var fire = player_inside.get_node("FireArea")
		if fire:
			fire.take_damage(damage * delta)
