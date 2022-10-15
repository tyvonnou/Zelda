extends KinematicBody2D

var swordLoading := false
var swordLoad := false
var personnage

func cleanShape() -> void:
	$RightShape.disabled = true
	$LeftShape.disabled = true
	$DownShape.disabled = true
	$UpShape.disabled = true

func playAnimation(animationName: String, sprite: AnimatedSprite) -> void:
	if (!$SwordSprite.playing && animationName.begins_with("sword")):
		$SwordSound.play()
	sprite.visible = true
	match animationName:
		"sword-right":
			if sprite.flip_h:
				sprite.z_index = 0
				sprite.position.x = -2
				sprite.position.y = -2
				$LeftShape.disabled = false
			else:
				sprite.z_index = 0
				sprite.position.x = -8
				sprite.position.y = -2
				$RightShape.disabled = false
		"sword-up":
			sprite.z_index = 0
			sprite.position.x = -2
			sprite.position.y = 4
			$UpShape.disabled = false
		"sword-down":
			sprite.z_index = 1
			sprite.position.x = -8
			sprite.position.y = -8
			$DownShape.disabled = false
		"sword-up-load":
			sprite.z_index = 0
			sprite.position.x = -2
			sprite.position.y = 4
			$UpShape.disabled = false
	
	sprite.play(animationName)

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
		$SwordSprite.flip_h = sign(personnage.look_direction.x) == -1.0

	# Sword action 
	if (Input.is_action_just_pressed("ui_accept") && equippedSword):
		get_tree().get_root().set_disable_input(true)
		match personnage.SPRITE_MAP[personnage.look_direction]:
			"mv-right":
				playAnimation("sword-right", $SwordSprite)
			"mv-up", "mv-up-right":
				playAnimation("sword-up", $SwordSprite)
			"mv-down", "mv-bottom-right":
				playAnimation("sword-down", $SwordSprite)
	
	# Stop attack
	if Input.is_action_just_released("ui_accept") && equippedSword:
		swordLoading = false
		swordLoad = false
		stopAnimation($SwordSprite)
		stopAnimation($StarSprite)


	
func _on_Sword_animation_finished():
	if Input.is_action_pressed("ui_accept") && !swordLoading && !swordLoad:
		swordLoading = true
		match personnage.SPRITE_MAP[personnage.look_direction]:
			"mv-up-right", "mv-up":
				playAnimation("sword-up-load", $SwordSprite)
				playAnimation("star-up-loading", $StarSprite)
			_:
				stopAnimation($SwordSprite) 
	elif !(swordLoading || swordLoad):
			stopAnimation($SwordSprite)       

func _on_Star_animation_finished():
	if Input.is_action_pressed("ui_accept") && swordLoading:
		swordLoading = false
		swordLoad = true
		match personnage.SPRITE_MAP[personnage.look_direction]:
			"mv-up-right", "mv-up":
				playAnimation("star-up-load", $StarSprite)     

