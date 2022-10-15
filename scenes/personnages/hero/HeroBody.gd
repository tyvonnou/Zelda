extends KinematicBody2D

func _process(_delta: float) -> void:
	
	# Movement 
	var input_vector := Vector2(
		float(Input.is_action_pressed("ui_right")) - float(Input.is_action_pressed("ui_left")),
		float(Input.is_action_pressed("ui_down")) - float(Input.is_action_pressed("ui_up"))
	)

	# Play movements and update look direction
	if (input_vector.length() > 0.0):
			get_parent().look_direction = input_vector
			$HeroSprite.flip_h = sign(get_parent().look_direction.x) == -1.0
			if get_parent().SPRITE_MAP[input_vector].begins_with("mv-") && !Input.is_action_pressed("ui_accept"):
				$HeroSprite.play(get_parent().SPRITE_MAP[input_vector])
				$SwordBody.stopAnimation($SwordBody/SwordSprite)
	
	# Stop movement
	if (Input.is_action_just_released("ui_right") || 
	Input.is_action_just_released("ui_left") || 
	Input.is_action_just_released("ui_down") || 
	Input.is_action_just_released("ui_up")):
		if $HeroSprite.get_animation().begins_with("mv-"):
			$HeroSprite.stop()
			$HeroSprite.frame = 0
		
	if (Input.is_action_just_pressed("ui_accept") && get_parent().equipment["ui_accept"] == "sword"):
		get_tree().get_root().set_disable_input(true)
		match get_parent().SPRITE_MAP[get_parent().look_direction]:
			"mv-right":
				$HeroSprite.play("sword-right")
			"mv-up":
				$HeroSprite.play("sword-up")
			"mv-up-right":
				$HeroSprite.play("sword-up")
			"mv-down":
				$HeroSprite.play("sword-down")
			"mv-bottom-right":
				$HeroSprite.play("sword-down")

func _on_Hero_animation_finished():
	get_tree().get_root().set_disable_input(false)
	$HeroSprite.stop()
	$HeroSprite.frame = 0
