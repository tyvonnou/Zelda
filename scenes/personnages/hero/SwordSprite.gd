extends AnimatedSprite


func playAnimation(animationName: String) -> void:
		
	visible = true
	match animationName:
		"sword-right":
			if flip_h:
				z_index = 0
				position.x = -2
				position.y = -2
			else:
				z_index = 0
				position.x = -8
				position.y = -2
		"sword-up":
			z_index = 0
			position.x = -2
			position.y = 4
		"sword-up-release":
			if !flip_v:
				z_index = 0
				position.x = 8
				position.y = -12
			else:
				z_index = 1
				position.x = 11
				position.y = -9
		"load-sword-up":
			z_index = 0
			position.x = -2
			position.y = 9
		"sword-down":
			z_index = 1
			position.x = -8
			position.y = -8

	if (!playing && animationName.begins_with("sword-")):
		$SwordSound.play()
	play(animationName)
	
func _ready():
	pass 
