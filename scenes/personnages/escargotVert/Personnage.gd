extends KinematicBody2D

onready var _animated_sprite = $EscargotVert
var speed = 170
var velocity = Vector2()

func get_input() -> void:
	velocity = Vector2()
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		_animated_sprite.flip_h = false
		_animated_sprite.flip_v = false
		_animated_sprite.play("right")
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		_animated_sprite.flip_h = true
		_animated_sprite.flip_v = false
		_animated_sprite.play("right")
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		_animated_sprite.flip_h = false
		_animated_sprite.flip_v = true
		_animated_sprite.play("up")
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		_animated_sprite.flip_h = false
		_animated_sprite.flip_v = false
		_animated_sprite.play("up")
	 
	if (Input.is_action_just_released("ui_up") || Input.is_action_just_released("ui_down") ||
		Input.is_action_just_released("ui_left") || Input.is_action_just_released("ui_right")):
			_animated_sprite.stop()
			
	velocity = velocity.normalized() * speed
	
	

func _physics_process(delta):
	get_input()
	move_and_collide(velocity * delta)
