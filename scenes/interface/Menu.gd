extends Control

signal scene_change_requested(next_scene)

func _process(_delta: float) -> void:
	# Button effect after sound is playing
	if ($Buttons.buttonPressed != "NONE"):
		match ($Buttons.buttonPressed):
			"START":
				get_tree().get_root().set_disable_input(false)       
				emit_signal("scene_change_requested", "res://scenes/personnages/escargotVert/Personnage.tscn")
				$Buttons.buttonPressed = "NONE"
			"OPTIONS":
				get_tree().get_root().set_disable_input(false) 
				$Buttons.buttonPressed = "NONE"      
			"QUIT":
				get_tree().quit()
