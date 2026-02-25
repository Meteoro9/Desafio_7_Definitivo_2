extends RayCast2D

var sfx_grounded : AudioStream = preload("res://Audio/SFX/Player/Get-Grounded-2-SFX.ogg")
var audio_player : AudioStreamPlayer2D

var was_colliding_previous_frame : bool = false
var is_currently_colliding : bool = true

func _ready() -> void:
	audio_player = AudioStreamPlayer2D.new()
	add_child(audio_player)
	audio_player.stream = sfx_grounded
	audio_player.bus = "SFX"
	audio_player.volume_db = 8.0

func _process(_delta: float) -> void:
	is_currently_colliding = false
	if is_colliding() and get_collider().is_in_group("Enviroment"):
		is_currently_colliding = true
	
	if is_currently_colliding and not was_colliding_previous_frame:
		var pitch = randf_range(0.7,1.3)
		audio_player.pitch_scale = pitch
		audio_player.play()
		print("Se detectó aterrizaje")
	
	was_colliding_previous_frame = is_currently_colliding
