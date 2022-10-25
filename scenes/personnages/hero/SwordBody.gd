extends KinematicBody2D

var personnage
var beRelease = true
func cleanShape() -> void:
	$RightShape3.disabled = true
	$RightShape2.disabled = true
	$RightShape.disabled = true
	$LeftShape3.disabled = true
	$LeftShape2.disabled = true
	$LeftShape.disabled = true
	$DownShape4.disabled = true
	$DownShape3.disabled = true
	$DownShape2.disabled = true
	$DownShape.disabled = true
	$UpShape3.disabled = true
	$UpShape2.disabled = true
	$UpShape.disabled = true
	
func stopAnimation(sprite: AnimatedSprite) -> void:
	sprite.visible = false
	sprite.frame = 0
	sprite.stop() 
	cleanShape()
	get_tree().get_root().set_disable_input(false)


	
func _process(_delta):
	personnage = get_parent().get_parent()
	var equippedSword = personnage.equipment["ui_accept"] == "sword"
	# Movement 

	if (!$SwordSprite.playing):
		cleanShape()
		$SwordSprite.flip_h = sign(personnage.look_direction.x) == -1.0
	# Sword action 
	if (Input.is_action_just_pressed("ui_accept") && equippedSword) && !$SwordSprite.playing:
		beRelease = false
		match personnage.SPRITE_MAP[personnage.look_direction]:
			"mv-right":
				$SwordSprite.playAnimation("sword-right")
			"mv-up", "mv-up-right":
				$SwordSprite.playAnimation("sword-up")
			"mv-down", "mv-bottom-right":
				$SwordSprite.playAnimation("sword-down")
	
	
	if Input.is_action_just_released("ui_accept"):
		beRelease = true
		# Spin attack
		if personnage.swordLoad:
			personnage.swordLoad = false
			match personnage.SPRITE_MAP[personnage.look_direction]:
				"mv-up":
					$SwordSprite.playAnimation("spin-up")
				"mv-down":
					$SwordSprite.playAnimation("spin-down")
				"mv-right":
					if !$SwordSprite.flip_h:
						$SwordSprite.playAnimation("spin-right")
					else:
						$SwordSprite.flip_h = false
						$SwordSprite.playAnimation("spin-left")
		# Unload
		elif $SwordSprite.get_animation().ends_with("load") || $SwordSprite.get_animation().ends_with("loading"):
			stopAnimation($SwordSprite)


		
func _on_Sword_animation_finished():
	if !beRelease:
		match $SwordSprite.get_animation():
			"sword-up":
				$SwordSprite.playAnimation("sword-up-loading")
			"sword-up-loading":
				personnage.swordLoad = true
				$SwordSprite.playAnimation("sword-up-load")
			"sword-right":
				$SwordSprite.playAnimation("sword-right-loading")
			"sword-right-loading":
				personnage.swordLoad = true
				$SwordSprite.playAnimation("sword-right-load")
			"sword-down":
				$SwordSprite.playAnimation("sword-down-loading")
			"sword-down-loading":
				personnage.swordLoad = true
				$SwordSprite.playAnimation("sword-down-load")
	else:
		stopAnimation($SwordSprite)
	if ($SwordSprite.get_animation() == "spin-left"):
		$SwordSprite.flip_h = true

	

