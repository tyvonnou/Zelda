extends AnimatedSprite


func playAnimation(animationName: String) -> void:
		
	visible = true
	match animationName:
		"sword-right":
			if !flip_h:
				z_index = 0
				position.x = 15
				position.y = -15
			else:
				z_index = 0
				position.x = -15
				position.y = -15
		"sword-up":
			z_index = 0
			position.x = 15
			position.y = -15
		"sword-up-release":
			if !flip_v:
				z_index = 0
				position.x = 8
				position.y = -12
			else:
				z_index = 1
				position.x = 11
				position.y = -9
		"sword-right-load", "sword-right-loading":
			if !flip_h:
				z_index = 0
				position.x = 22
				position.y = 9
			else:
				z_index = 0
				position.x = -22
				position.y = 9
		"sword-up-load", "sword-up-loading":
			z_index = 0
			position.x = -8
			position.y = -23
		"sword-down":
			z_index = 1
			position.x = -15
			position.y = 15
		"sword-down-load", "sword-down-loading":
			z_index = 0
			position.x = 5
			position.y = 28

	if (!playing && animationName.begins_with("sword-")):
		$SwordSound.play()
	play(animationName)
	
func _ready():
	pass 
