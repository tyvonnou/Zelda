extends AnimatedSprite

func _process(_delta):
	if Input.is_action_pressed("ui_accept"):
		play("sword-right")

func _on_Sword_animation_finished():
	stop()
