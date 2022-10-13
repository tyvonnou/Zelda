extends ParallaxBackground

export var LIGHT_SPEED = -0.5
export var BACKGROUND_SPEED = -2
export var MIDDLE_SPEED = -3
export var FRONT_SPEED = -6

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	# Parrallax effect
	$Layer2.motion_offset.x += delta * LIGHT_SPEED
	$Layer1.motion_offset.x += delta * BACKGROUND_SPEED
	$Layer3.motion_offset.x += delta * MIDDLE_SPEED
	$Layer4.motion_offset.x += delta * FRONT_SPEED
