extends AnimatedSprite

const SPRITE_MAP := {
	Vector2.ZERO: "STOP",
	Vector2.RIGHT: "right",
	Vector2.DOWN: "down",
	Vector2.LEFT: "right",
	Vector2.UP: "up",
	Vector2(1.0,-1.0): "up-right",
	Vector2(-1.0,-1.0): "up-right",
	Vector2(1.0,1.0): "bottom-right",
	Vector2(-1.0,1.0): "bottom-right",
}

var look_direction := Vector2.RIGHT

func _process(delta: float) -> void:
	
	var input_vector := Vector2(
		float(Input.is_action_pressed("ui_right")) - float(Input.is_action_pressed("ui_left")),
		float(Input.is_action_pressed("ui_down")) - float(Input.is_action_pressed("ui_up"))
	)
	print(input_vector)	
		
	if (input_vector.length() > 0.0 and input_vector != look_direction) || (input_vector.length() > 0.0 && !is_playing()):
			play(SPRITE_MAP[input_vector])
			look_direction = input_vector
			flip_h = sign(look_direction.x) == -1.0
			
	if Input.is_action_pressed("ui_accept"):
		play("sword-right")
	
	if (Input.is_action_just_released("ui_right") || 
	Input.is_action_just_released("ui_left") ||Input.is_action_just_released("ui_down") || 
	Input.is_action_just_released("ui_up")):
		stop()
		frame = 0


func _on_Hero_animation_finished():
	stop()
	frame = 0
