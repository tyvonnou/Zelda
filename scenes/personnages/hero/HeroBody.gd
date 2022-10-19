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
	if (input_vector.length() > 0.0):
			personnage.look_direction = input_vector
			if $HeroSprite.get_animation() != "sword-up-load":
				$HeroSprite.flip_h = sign(personnage.look_direction.x) == -1.0
			# Basic movement 
			if get_parent().SPRITE_MAP[input_vector].begins_with("mv-") && !Input.is_action_pressed("ui_accept"):
				$HeroSprite.play(get_parent().SPRITE_MAP[input_vector])
				$SwordBody.stopAnimation($SwordBody/SwordSprite)
			# Load sword movement 
			if get_parent().SPRITE_MAP[input_vector].begins_with("mv-") && !$HeroSprite.playing:
				$HeroSprite.playing = true
	
	# Stop movement
	if (Input.is_action_just_released("ui_right") || 
	Input.is_action_just_released("ui_left") || 
	Input.is_action_just_released("ui_down") || 
	Input.is_action_just_released("ui_up")):
		match $HeroSprite.get_animation():
			"mv-bottom-right", "mv-down", "mv-right", "mv-up", "mv-up-right", "sword-up-load":
				$HeroSprite.stop()
				$HeroSprite.frame = 0
		
	if (Input.is_action_just_pressed("ui_accept") && equippedSword):
		get_tree().get_root().set_disable_input(true)
		match personnage.SPRITE_MAP[personnage.look_direction]:
			"mv-right":
				$HeroSprite.play("sword-right")
			"mv-up", "mv-up-right":
				$HeroSprite.play("sword-up")
			"mv-down", "mv-bottom-right":
				$HeroSprite.play("sword-down")

	if Input.is_action_just_released("ui_accept") && personnage.swordLoad:
		match $HeroSprite.get_animation():
			"sword-up-load":
				$HeroSprite.flip_h = false 
				$HeroSprite.play("sword-up-release")
			"sword-down-load":
				$HeroSprite.play("sword-down-release")
		
func _on_Hero_animation_finished():
	if Input.is_action_pressed("ui_accept"):
		match $SwordBody/SwordSprite.get_animation():
			"sword-up":
				$HeroSprite.play("sword-up-load") 
				$HeroSprite.playing = false
			"sword-down":
				$HeroSprite.play("sword-down-load")    

	else:
		match $HeroSprite.get_animation():
			"sword-up-release":
				$HeroSprite.play("mv-up") 
			"sword-down":
				$HeroSprite.play("sword-down-load")  
				
		get_tree().get_root().set_disable_input(false)
		$HeroSprite.stop()
		$HeroSprite.frame = 0
