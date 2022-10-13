extends CanvasLayer

export (float) var fade_duration := 1

onready var color_rect: ColorRect = $ColorRect
onready var tween: Tween = $Tween


func _ready() -> void:
	tween.interpolate_property(color_rect, "modulate:a", 1, 0, fade_duration)
	tween.interpolate_callback(color_rect, fade_duration, "hide")
	tween.start()


func transition_to(next_scene) -> void:
	color_rect.show()
	tween.interpolate_property(color_rect, "modulate:a", 0, 1, fade_duration)
	tween.start()
	yield(tween, "tween_all_completed")
	get_tree().change_scene(next_scene)
