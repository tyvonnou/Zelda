extends KinematicBody2D

onready var _animated_sprite = $EscargotVert
var speed = 170
var velocity = Vector2()

func get_input():
	velocity = Vector2()
		
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		_animated_sprite.play("right")
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		_animated_sprite.play("left")
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		_animated_sprite.play("down")
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		_animated_sprite.play("up")
	
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	move_and_collide(velocity * delta)
