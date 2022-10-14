extends Control

signal scene_change_requested(next_scene)

func _process(_delta: float) -> void:
	# Button effect redirect scene
	if ($Buttons.buttonPressed != "NONE"):
		match ($Buttons.buttonPressed):
			"START":
				get_tree().get_root().set_disable_input(true)       
				$Buttons/ButtonSelected.play()
				emit_signal("scene_change_requested", "res://scenes/personnages/hero/Personnage.tscn") 
				$Buttons/ButtonHover.volume_db = -80
				$Buttons.buttonPressed = "NONE" 
				get_tree().get_root().set_disable_input(false)     
			"OPTIONS":
				get_tree().get_root().set_disable_input(true)       
				$Buttons/ButtonSelected.play()
				$Buttons.buttonPressed = "NONE"
				get_tree().get_root().set_disable_input(false) 
			"QUIT":
				get_tree().get_root().set_disable_input(true)       
				$Buttons/ButtonSelected.play()
				$Buttons.buttonPressed = "NONE"
				get_tree().quit()
