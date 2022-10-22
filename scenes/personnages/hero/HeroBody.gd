extends KinematicBody2D

var personnage
var lockLookPosition = false
var flip_h 


					
func _process(_delta: float) -> void:
	
	personnage = get_parent()
	var equippedSword = personnage.equipment["ui_accept"] == "sword"

	# Movement 
	var input_vector := Vector2(
		float(Input.is_action_pressed("ui_right")) - float(Input.is_action_pressed("ui_left")),
		float(Input.is_action_pressed("ui_down")) - float(Input.is_action_pressed("ui_up"))
	)

	# Play movements and update look direction
	if (input_vector.length() > 0.0 && !$HeroSprite.playing):
			if !lockLookPosition:
				personnage.look_direction = input_vector
			# Flip H
			$HeroSprite.flip_h = sign(personnage.look_direction.x) == -1.0
			# Basic movement 
			if get_parent().SPRITE_MAP[personnage.look_direction].begins_with("mv-") && !$HeroSprite.playing:
				$HeroSprite.play(get_parent().SPRITE_MAP[personnage.look_direction])
				if !lockLookPosition:
					$SwordBody.stopAnimation($SwordBody/SwordSprite)
			# Load sword movement 
			if get_parent().SPRITE_MAP[personnage.look_direction].begins_with("mv-") && !$HeroSprite.playing:
				$HeroSprite.playing = true
	
	# Stop movement
	if (Input.is_action_just_released("ui_right") || 
	Input.is_action_just_released("ui_left") || 
	Input.is_action_just_released("ui_down") || 
	Input.is_action_just_released("ui_up")):
		match $HeroSprite.get_animation():
			"mv-bottom-right", "mv-down", "mv-right", "mv-up", "mv-up-right":
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

	if Input.is_action_just_released("ui_accept"):
		if lockLookPosition:
			lockLookPosition = false
		if personnage.swordLoad:
			flip_h = $HeroSprite.flip_h
			$HeroSprite.flip_h = false

			match personnage.SPRITE_MAP[personnage.look_direction]:
				"mv-right":
					if !flip_h:
						$HeroSprite.play("spin-right")
					else:
						$HeroSprite.play("spin-left")
				"mv-up", "mv-up-right":
					$HeroSprite.play("spin-up")
				"mv-down", "mv-bottom-right":
					$HeroSprite.play("spin-down")
			
				
				
				
func _on_Hero_animation_finished():
	if $HeroSprite.get_animation().begins_with("spin"):
		$HeroSprite.play(personnage.SPRITE_MAP[personnage.look_direction])
		$HeroSprite.flip_h = flip_h
		$HeroSprite.stop()

	if Input.is_action_pressed("ui_accept"):
		match $HeroSprite.get_animation():
			# Stuck position when sword load
			"sword-up", "sword-down", "sword-right":
				lockLookPosition = true
				
	get_tree().get_root().set_disable_input(false)
	$HeroSprite.stop()
	$HeroSprite.frame = 0
