extends Node2D

const SPRITE_MAP := {
	Vector2.ZERO: "STOP",
	Vector2.RIGHT: "mv-right",
	Vector2.DOWN: "mv-down",
	Vector2.LEFT: "mv-right",
	Vector2.UP: "mv-up",
	Vector2(1.0,-1.0): "mv-up",
	Vector2(-1.0,-1.0): "mv-up",
	Vector2(1.0,1.0): "mv-down",
	Vector2(-1.0,1.0): "mv-down",
}

# Owned item
export var inventory := {
	"sword": true,
}

# Equipment key -> item
export var equipment := {
	"ui_accept": null,
}

# auto equip sword
func _ready():
	if inventory["sword"]:
		equipment["ui_accept"] = "sword"

export var look_direction := Vector2.ZERO
export var swordLoad := false
var speed := 170

func _physics_process(_delta) -> void:
	var input_vector := Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	print(input_vector)
	var move_direction := input_vector.normalized()
	var _err = $HeroBody.move_and_slide(speed * move_direction)
