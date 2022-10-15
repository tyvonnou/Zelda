extends KinematicBody2D

func cleanShape() -> void:
	$RightShape.disabled = true
	$LeftShape.disabled = true
	$DownShape.disabled = true
	$UpShape.disabled = true

func playAnimation(animationName: String) -> void:
	get_tree().get_root().set_disable_input(true)
	if (!$SwordSound.playing && !$SwordSprite.playing):
		$SwordSound.play()
	match animationName:
		"sword-right":
			if $SwordSprite.flip_h:
				$SwordSprite.z_index = 0
				$SwordSprite.position.x = -2
				$SwordSprite.position.y = -2
				$LeftShape.disabled = false
			else:
				$SwordSprite.z_index = 0
				$SwordSprite.position.x = -8
				$SwordSprite.position.y = -2
				$RightShape.disabled = false
		"sword-up":
			$SwordSprite.z_index = 0
			$SwordSprite.position.x = -2
			$SwordSprite.position.y = 4
			$UpShape.disabled = false
		"sword-down":
			$SwordSprite.z_index = 1
			$SwordSprite.position.x = -4
			$SwordSprite.position.y = -8
			$DownShape.disabled = false
		_:
			$SwordSprite.play(animationName)

func stopAnimation() -> void:
	$SwordSprite.visible = false
	$SwordSprite.frame = 0
	cleanShape()
	get_tree().get_root().set_disable_input(false)
	$SwordSprite.stop() 
	
func _process(_delta):
	
	var personnage := get_parent().get_parent()
	
	# Movement 
	var input_vector := Vector2(
		float(Input.is_action_pressed("ui_right")) - float(Input.is_action_pressed("ui_left")),
		float(Input.is_action_pressed("ui_down")) - float(Input.is_action_pressed("ui_up"))
	)
	
	if (input_vector.length() > 0.0):
		cleanShape()
		$SwordSprite.flip_h = sign(personnage.look_direction.x) == -1.0

	# Sword action 
	if (Input.is_action_pressed("ui_accept")):
		$SwordSprite.visible = true
		match personnage.SPRITE_MAP[personnage.look_direction]:
			"mv-right":
				playAnimation("sword-right")
				$SwordSprite.play("sword-right")
			"mv-up":
				playAnimation("sword-up")
				$SwordSprite.play("sword-up")
			"mv-down":
				playAnimation("sword-down")
				$SwordSprite.play("sword-down")
	

func _on_Sword_animation_finished():
	stopAnimation()       
