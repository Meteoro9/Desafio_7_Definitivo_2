class_name ButtonEffectsModule extends ButtonEffectsModuleSimple

@export var rotation_amount: float = 3.0

func _on_button_pressed() -> void:
	_select_pitch()
	pressed_player.play()
	reset_tween()
	tween.tween_property(button, "scale", scale_amount, anim_duration).from(Vector2(0.8, 0.8))
	tween.tween_property(button, "rotation_degrees", rotation_amount * [-1, 1].pick_random(), 
		anim_duration).from(0)

func _on_mouse_hovered(hovered: bool) -> void:
	_select_pitch()
	hover_player.play()
	reset_tween()
	tween.tween_property(button, "scale", 
		scale_amount if hovered else Vector2.ONE, anim_duration)
	tween.tween_property(button, "rotation_degrees", 
		rotation_amount * [-1, 1].pick_random() if hovered else 0.0, anim_duration)

func reset_tween() -> void:
	if tween: tween.kill()
	tween = create_tween().set_ease(ease_type).set_trans(trans_type).set_parallel(true)
