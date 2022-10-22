extends KinematicBody2D

var personnage
var lock_flip_h = false

func cleanShape() -> void:
	$RightShape.disabled = true
	$LeftShape.disabled = true
	$DownShape.disabled = true
	$UpShape.disabled = true

func stopAnimation(sprite: AnimatedSprite) -> void:
	sprite.visible = false
	sprite.frame = 0
	cleanShape()
	get_tree().get_root().set_disable_input(false)
	sprite.stop() 
	
func _process(_delta):
	personnage = get_parent().get_parent()
	var equippedSword = personnage.equipment["ui_accept"] == "sword"
	# Movement 
	var input_vector := Vector2(
		float(Input.is_action_pressed("ui_right")) - float(Input.is_action_pressed("ui_left")),
		float(Input.is_action_pressed("ui_down")) - float(Input.is_action_pressed("ui_up"))
	)
	
	if (input_vector.length() > 0.0 && !$SwordSprite.playing):
		cleanShape()
		$SwordSprite.flip_h = sign(personnage.look_direction.x) == -1.0
	# Sword action 
	if (Input.is_action_just_pressed("ui_accept") && equippedSword):
		get_tree().get_root().set_disable_input(true)
		match personnage.SPRITE_MAP[personnage.look_direction]:
			"mv-right":
				if !$SwordSprite.flip_h:
					$RightShape.disabled = false
				else:
					$LeftShape.disabled = false
				$SwordSprite.playAnimation("sword-right")
			"mv-up", "mv-up-right":
				$UpShape.disabled = false
				$SwordSprite.playAnimation("sword-up")
			"mv-down", "mv-bottom-right":
				$DownShape.disabled = false
				$SwordSprite.playAnimation("sword-down")
	
	
	if Input.is_action_just_released("ui_accept"):
		# Spin attack
		if personnage.swordLoad:
			get_tree().get_root().set_disable_input(true)
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
			personnage.swordLoad = false
		# Unload
		elif $SwordSprite.get_animation().ends_with("load") || $SwordSprite.get_animation().ends_with("loading"):
			stopAnimation($SwordSprite)


		
func _on_Sword_animation_finished():
	if Input.is_action_pressed("ui_accept"):
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

	get_tree().get_root().set_disable_input(false)
	

