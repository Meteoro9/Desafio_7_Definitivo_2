extends Node
class_name MusicManager # Acceso global con GlobalMusicManager

enum Scene_State { MENU, LEVEL1, PAUSE, WIN, LOOSE }
var current_state : Scene_State = Scene_State.MENU : set = set_scene_state

var music_player : AudioStreamPlayer

var track_list = { 
	Scene_State.MENU: preload("res://Audio/Music/poopie pack/town.ogg"),
	Scene_State.LEVEL1: preload("res://Audio/Music/poopie pack/boss battle.ogg"),
	Scene_State.PAUSE: preload("res://Audio/Music/poopie pack/shop.ogg"),
	Scene_State.WIN: preload("res://Audio/Music/poopie pack/blossom.ogg"),
	Scene_State.LOOSE: preload("res://Audio/Music/poopie pack/journey.ogg")
}

func _ready() -> void:
	# Creamos instancia del AudioStreamPlayer
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	music_player.bus = "Music"
	
	# Hacemos todas las canciones loopeables
	for track in track_list.values():
		if track is AudioStream:
			track.loop = true # Loop para todas
	
	if track_list.has(current_state):
		music_player.stream = track_list[current_state]
		music_player.play()

func set_scene_state(new_state: Scene_State):
	if current_state == new_state:
		return # Si la escena es la misma, no hacemos nada
	current_state = new_state
	fade_transition_music(new_state)

func fade_transition_music(state: Scene_State):
	# Crear sistema de comparación
	var new_song = track_list[state]
	
	var tween = create_tween()
	tween.tween_property(music_player, "volume_db",
		 -80.0, 0.3).set_trans(Tween.TRANS_SINE)
	
	tween.tween_callback(func():
		music_player.stream = new_song
		music_player.play()
	)
	
	tween.tween_property(music_player, "volume_db", 
		0.0, 0.5).set_trans(Tween.TRANS_SINE)

func detect_finished():
	if music_player.finished:
		music_player.stream = track_list[current_state]

func _process(_delta: float) -> void:
	#detect_finished()
	pass
