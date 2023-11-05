extends Node

var akso: Vector2

func get_akso() -> Vector2:
	akso.x = int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left"))
	akso.y = int(Input.is_action_pressed("ui_down"))-int(Input.is_action_pressed("ui_up"))
	return akso.normalized();

