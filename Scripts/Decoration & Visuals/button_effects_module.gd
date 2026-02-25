class_name ButtonEffectsModule extends ButtonEffectsModuleSimple

@export var rotation_amount: float = 3.0

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
	tween.tween_property(button, "rotation_degrees", rotation_amount * [-1, 1].pick_random(), 
		anim_duration).from(0)

func _on_mouse_hovered(hovered: bool) -> void:
	hover_player.play()
	reset_tween()
	tween.tween_property(button, "scale", 
		scale_amount if hovered else Vector2.ONE, anim_duration)
	tween.tween_property(button, "rotation_degrees", 
		rotation_amount * [-1, 1].pick_random() if hovered else 0.0, anim_duration)

func reset_tween() -> void:
	if tween: tween.kill()
	tween = create_tween().set_ease(ease_type).set_trans(trans_type).set_parallel(true)
