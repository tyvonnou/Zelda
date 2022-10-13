extends VBoxContainer

export var keyboardPressed = false 
export var buttonPressed = "NONE"

func _process(delta) -> void:

	# Select when keyboard pressed
	if ((Input.is_action_pressed("ui_right") ||
		Input.is_action_pressed("ui_left") ||
		Input.is_action_pressed("ui_up") ||
		Input.is_action_pressed("ui_down")) && !keyboardPressed):
			$StartButton.grab_focus()
			keyboardPressed = true
	
	# Remove select keyboard if is selected with the mouse 
	if (($StartButton.is_hovered() ||
		$OptionButton.is_hovered() || 
		$QuitButton.is_hovered()) && keyboardPressed):
			$StartButton.release_focus()
			$OptionButton.release_focus()
			$QuitButton.release_focus()
			keyboardPressed = false
	
func _on_StartButton_button_down():
	$ButtonSelected.play()
	buttonPressed = "START"
	get_tree().get_root().set_disable_input(true)       
	
func _on_OptionButton_button_down():
	$ButtonSelected.play()
	buttonPressed = "OPTIONS"
	get_tree().get_root().set_disable_input(true)       

func _on_QuitButton_button_down():
	$ButtonSelected.play()
	buttonPressed = "QUIT"
	get_tree().get_root().set_disable_input(true)       
