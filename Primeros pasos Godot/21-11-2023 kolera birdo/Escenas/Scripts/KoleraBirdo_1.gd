extends Node2D
var ultima_posicion: Vector2

func _process(delta):
	var raton_posicion = get_global_mouse_position()
	if Input.is_action_just_pressed("mover_arrastre"):
		ultima_posicion= raton_posicion
		var posicion_raton = ultima_posicion-raton_posicion
		position = clamp_posicion(posicion_raton)
		#ultima_posicion = raton_posicion

func clamp_posicion (pos: Vector2)->Vector2:
	var ventana_tamaño = get_viewport_rect().size/2
	pos.x =clamp(pos.x, ventana_tamaño.x,ventana_tamaño.x)
	pos.y =clamp(pos.y, ventana_tamaño.y,ventana_tamaño.y)
	return pos
