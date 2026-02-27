extends Area2D
class_name WoodBehaviour

var player_inside : CandlePlayer = null
var audio_player : AudioStreamPlayer2D
var wood_fire_audio : AudioStream = load("res://Audio/SFX/Elements/Wood-Fire-SFX.mp3")
var audio_emmited : bool = false

func _ready() -> void:
	audio_player = AudioStreamPlayer2D.new()
	add_child(audio_player)
	audio_player.bus = "SFX"
	audio_player.stream = wood_fire_audio

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is FireBehaviour:
		if !audio_emmited: audio_player.play()
		player_inside = area.get_parent()
		print("El player quemó la madera")
		audio_emmited = true

func _process(_delta: float) -> void:
	if player_inside:
		var fire = player_inside.get_node("FireArea")
		player_inside = null
		if fire and $AnimationPlayer.is_playing():
			$AnimationPlayer.play("fire")

func _on_timer_timeout() -> void:
	queue_free()

func kill():
	$Timer.start()
	print("Comenzó el timer")
