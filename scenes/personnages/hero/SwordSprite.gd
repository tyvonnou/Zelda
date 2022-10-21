extends AnimatedSprite


func playAnimation(animationName: String) -> void:
		
	visible = true
	match animationName:
		"sword-right":
			if flip_h:
				z_index = 0
				position.x = -20
				position.y = -31
			else:
				z_index = 0
				position.x = 10
				position.y = -31
		"sword-up":
			z_index = 0
			position.x = 10
			position.y = -30
		"sword-up-release":
			if !flip_v:
				z_index = 0
				position.x = 8
				position.y = -12
			else:
				z_index = 1
				position.x = 11
				position.y = -9
		"sword-up-load", "sword-up-loading":
			z_index = 0
			position.x = -13
			position.y = -38
		"sword-down":
			z_index = 1
			position.x = -20
			position.y = -0

	if (!playing && animationName.begins_with("sword-")):
		$SwordSound.play()
	play(animationName)
	
func _ready():
	pass 
