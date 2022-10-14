extends CanvasLayer

export var fade_duration := 1.0

onready var color_rect: ColorRect = $ColorRect
onready var tween: Tween = $Tween


func _ready() -> void:
	var _err := tween.interpolate_property(color_rect, "modulate:a", 1, 0, fade_duration)
	_err = tween.interpolate_callback(color_rect, fade_duration, "hide")
	_err = tween.start()


func transition_to(next_scene) -> void:
	color_rect.show()
	var _err := tween.interpolate_property(color_rect, "modulate:a", 0, 1, fade_duration)
	_err = tween.start()
	yield(tween, "tween_all_completed")
	_err = get_tree().change_scene(next_scene)
