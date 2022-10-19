extends AnimatedSprite

func playAnimation(animationName: String) -> void:
		
	visible = true
	match animationName:
		"star-up-loading":
			z_index = 1
			position.x = -15
			position.y = -39
		"star-down-loading":
			z_index = 1
			position.x = -15
			position.y = -20
	play(animationName)
	
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
