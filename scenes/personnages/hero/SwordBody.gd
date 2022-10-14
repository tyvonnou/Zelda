extends KinematicBody2D

func _process(_delta):

	# Movement 
	var input_vector := Vector2(
		float(Input.is_action_pressed("ui_right")) - float(Input.is_action_pressed("ui_left")),
		float(Input.is_action_pressed("ui_down")) - float(Input.is_action_pressed("ui_up"))
	)
	
	# Flip horizontal
	if (input_vector.length() > 0.0):
		get_parent().look_direction = input_vector
		$SwordSprite.flip_h = sign(get_parent().look_direction.x) == -1.0
	
	# Sword action 
	if (Input.is_action_pressed("ui_accept")):
		match get_parent().SPRITE_MAP[get_parent().look_direction]:
			"mv-right":
				get_tree().get_root().set_disable_input(true)       
				$SwordSprite.play("sword-right")

func _on_Sword_animation_finished():
	$SwordSprite.stop()
	get_tree().get_root().set_disable_input(false)       