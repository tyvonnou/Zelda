extends KinematicBody2D

var personnage

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
	
	if (input_vector.length() > 0.0):
		cleanShape()
		if (!$StarSprite.playing):
			$SwordSprite.flip_h = sign(personnage.look_direction.x) == -1.0
			$StarSprite.flip_h = sign(personnage.look_direction.x) == -1.0
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
	
	# Stop attack
	if Input.is_action_just_released("ui_accept"):
		if personnage.swordLoad:
			$SwordSprite.playAnimation("sword-up-release")
			personnage.swordLoad = false
		else:
			stopAnimation($SwordSprite)
		stopAnimation($StarSprite)

		
func _on_Sword_animation_finished():
	if Input.is_action_pressed("ui_accept"):
		match $SwordSprite.get_animation():
			"sword-up":
				$SwordSprite.flip_h = true 
				$SwordSprite.flip_v = false 
				$SwordSprite.playAnimation("sword-up-release")
				$SwordSprite.stop()
				$SwordSprite.frame = 0
				$StarSprite.playAnimation("star-up-loading")
			"sword-down":
				$SwordSprite.flip_h = true 
				$SwordSprite.flip_v = true 
				$SwordSprite.playAnimation("sword-up-release")
				$SwordSprite.stop()
				$SwordSprite.frame = 0
				$StarSprite.playAnimation("star-up-loading")
			_:
				if !$SwordSprite.get_animation().begins_with("load"):
					stopAnimation($SwordSprite)
	else:
		stopAnimation($SwordSprite)       

func _on_Star_animation_finished():
	if Input.is_action_pressed("ui_accept"):
		match $SwordSprite.get_animation():
			"sword-up-release":
				personnage.swordLoad = true
				$StarSprite.playAnimation("star-up-load") 
			_:
				if !$SwordSprite.get_animation().begins_with("load"):
					stopAnimation($SwordSprite) 

