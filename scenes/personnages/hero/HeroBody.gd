extends KinematicBody2D

var personnage

func _process(_delta: float) -> void:
	
	personnage = get_parent()
	var equippedSword = personnage.equipment["ui_accept"] == "sword"
	# Movement 
	var input_vector := Vector2(
		float(Input.is_action_pressed("ui_right")) - float(Input.is_action_pressed("ui_left")),
		float(Input.is_action_pressed("ui_down")) - float(Input.is_action_pressed("ui_up"))
	)

	# Play movements and update look direction
	if (input_vector.length() > 0.0 &&  !$SwordBody/StarSprite.playing):
			personnage.look_direction = input_vector
			$HeroSprite.flip_h = sign(personnage.look_direction.x) == -1.0
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
		
	if (Input.is_action_just_pressed("ui_accept") && equippedSword):
		get_tree().get_root().set_disable_input(true)
		match personnage.SPRITE_MAP[personnage.look_direction]:
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

	if Input.is_action_just_released("ui_accept") && personnage.swordLoad:
			$HeroSprite.play("sword-up-release")
		
func _on_Hero_animation_finished():
	if Input.is_action_pressed("ui_accept"):
		match $SwordBody/SwordSprite.get_animation():
			"sword-up":
				$HeroSprite.play("load-sword-up")     

	else:
		get_tree().get_root().set_disable_input(false)
		$HeroSprite.stop()
		$HeroSprite.frame = 0
