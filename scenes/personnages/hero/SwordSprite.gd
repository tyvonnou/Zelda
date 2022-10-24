extends AnimatedSprite

var audio_stream := []
func rand_pick(array: Array):
	return array[randi() % len(array)]
	
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
		$SwordSound.stream = rand_pick(audio_stream)
		$SwordSound.play()
	elif (animationName.ends_with("load") ):
		$SwordSound.stream = preload("res://assets/audio/sword/Oracle_Sword_Charge.wav")
		$SwordSound.play()
	elif (animationName.begins_with("spin-")):
		$SwordSound.stream = preload("res://assets/audio/sword/Oracle_Sword_Spin.wav")
		$SwordSound.play()
	play(animationName)
	
func _init() -> void:
	audio_stream.append(preload("res://assets/audio/sword/Oracle_Sword_Slash1.wav"))
	audio_stream.append(preload("res://assets/audio/sword/Oracle_Sword_Slash2.wav"))
	audio_stream.append(preload("res://assets/audio/sword/Oracle_Sword_Slash3.wav"))
	
	
func _process(_delta):
	match get_animation():
		"sword-down":
			match frame:
				1:
					get_parent().get_node("DownShape").disabled = false 
				2:
					get_parent().get_node("DownShape").disabled = true
					get_parent().get_node("DownShape2").disabled = false
				3:
					get_parent().get_node("DownShape2").disabled = true
					get_parent().get_node("DownShape3").disabled = false
		"sword-up":
			match frame:
				1:
					get_parent().get_node("UpShape").disabled = false 
				2:
					get_parent().get_node("UpShape").disabled = true
					get_parent().get_node("UpShape2").disabled = false
				3:
					get_parent().get_node("UpShape2").disabled = true
					get_parent().get_node("UpShape3").disabled = false
		"sword-right":
			if !flip_h:
				match frame:
					1:
						get_parent().get_node("RightShape").disabled = false 
					2:
						get_parent().get_node("RightShape").disabled = true
						get_parent().get_node("RightShape2").disabled = false
					3:
						get_parent().get_node("RightShape2").disabled = true
						get_parent().get_node("RightShape3").disabled = false
			else:
				match frame:
					1:
						get_parent().get_node("LeftShape").disabled = false 
					2:
						get_parent().get_node("LeftShape").disabled = true
						get_parent().get_node("LeftShape2").disabled = false
					3:
						get_parent().get_node("LeftShape2").disabled = true
						get_parent().get_node("LeftShape3").disabled = false
			
		"spin-up":
			match frame:
				0,1:
					get_parent().get_node("LeftShape").disabled = false 
					get_parent().get_node("LeftShape2").disabled = false
					z_index = 0
					position.x = -15
					position.y = -15
				2,3:
					get_parent().get_node("LeftShape").disabled = true
					get_parent().get_node("LeftShape2").disabled = true
					get_parent().get_node("DownShape").disabled = false 
					get_parent().get_node("DownShape2").disabled = false
					z_index = 1
					position.x = -15
					position.y = 15
				4,5:
					get_parent().get_node("DownShape").disabled = true 
					get_parent().get_node("DownShape2").disabled = true
					get_parent().get_node("DownShape3").disabled = false 
					get_parent().get_node("DownShape4").disabled = false
					get_parent().get_node("RightShape3").disabled = false
					z_index = 1
					position.x = 15
					position.y = 15
				6,7:
					get_parent().get_node("DownShape3").disabled = true 
					get_parent().get_node("DownShape4").disabled = true
					get_parent().get_node("RightShape3").disabled = true
					
					get_parent().get_node("RightShape2").disabled = false
					get_parent().get_node("UpShape2").disabled = false
					z_index = 0
					position.x = 15
					position.y = -15
		"spin-down":
			match frame:
				0,1:
					z_index = 1
					position.x = 15
					position.y = 15
				2,3:
					z_index = 0
					position.x = 15
					position.y = -15
				4,5:
					z_index = 0
					position.x = -15
					position.y = -15
				6,7:
					z_index = 0
					position.x = -15
					position.y = 15
		"spin-right":
			match frame:
				0,1:
					z_index = 0
					position.x = 15
					position.y = -15
				2,3:
					z_index = 0
					position.x = -15
					position.y = -15
				4,5:
					z_index = 0
					position.x = -15
					position.y = 15
				6,7:
					z_index = 0
					position.x = 15
					position.y = 15
		"spin-left":
			match frame:
				0,1:
					z_index = 1
					position.x = -15
					position.y = 15
				2,3:
					z_index = 0
					position.x = 15
					position.y = 15
				4,5:
					z_index = 0
					position.x = 15
					position.y = -15
				6,7:
					z_index = 0
					position.x = -15
					position.y = -15
