extends Node

func _ready():
	self.pause_mode = PAUSE_MODE_PROCESS
	set_process(true)

func _process(delta):
	if Input.is_action_just_pressed("pausa") and get_tree().paused:
		get_tree().paused = false
	elif Input.is_action_just_pressed("pausa") and get_tree().paused == false:
		get_tree().paused = true
