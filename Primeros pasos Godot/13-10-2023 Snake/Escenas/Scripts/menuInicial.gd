extends Control
var dirMain_Game = "uid://caxvbrmg032x3"

func _on_btn_jugar_pressed():
	get_tree().change_scene_to_file(dirMain_Game);

func _on_btn_salir_pressed():
	get_tree().quit()
