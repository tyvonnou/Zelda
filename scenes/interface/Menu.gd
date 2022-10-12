extends Control


# Declare member variables here. Examples:
var keyboardPressed = false 
export var LIGHT_SPEED = -0.02
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta) -> void:

	if ((Input.is_action_pressed("ui_right") ||
		Input.is_action_pressed("ui_left") ||
		Input.is_action_pressed("ui_up") ||
		Input.is_action_pressed("ui_down")) && !keyboardPressed):
			$VBoxContainer/StartButton.grab_focus()
			keyboardPressed = true
	
	if (($VBoxContainer/StartButton.is_hovered() ||
		$VBoxContainer/OptionButton.is_hovered() || 
		$VBoxContainer/QuitButton.is_hovered()) && keyboardPressed):
			$VBoxContainer/StartButton.release_focus()
			$VBoxContainer/OptionButton.release_focus()
			$VBoxContainer/QuitButton.release_focus()
			keyboardPressed = false
			
			
	$VBoxContainer/ParallaxBackground/Layer2.motion_offset.x += delta * -0.5
	$VBoxContainer/ParallaxBackground/Layer1.motion_offset.x += delta * -3
	$VBoxContainer/ParallaxBackground/Layer3.motion_offset.x += delta * -4
	$VBoxContainer/ParallaxBackground/Layer4.motion_offset.x += delta * -7
	
func _on_StartButton_button_down():
	get_tree().change_scene("res://scenes/personnages/escargotVert/Personnage.tscn")

func _on_OptionButton_button_down():
	pass

func _on_QuitButton_button_down():
	get_tree().quit() # Replace with function body.
