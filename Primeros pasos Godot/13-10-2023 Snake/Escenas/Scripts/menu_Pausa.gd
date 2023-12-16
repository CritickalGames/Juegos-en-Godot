extends Node2D
var dirMenuInicial= "uid://ci7x6on3xilj1"

func _on_continuar_pressed():
	visible=false
	get_tree().paused=false

func _on_volver_a_menu_pressed():
	get_tree().paused=false
	get_tree().change_scene_to_file(dirMenuInicial)

func _input(event):
	if (Input.is_anything_pressed()) and (event.as_text()=="Escape"):
		if visible:
			visible=false
			get_tree().paused=false		
