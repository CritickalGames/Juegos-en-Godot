extends Camera2D


var arrastrar_cam: bool
var ultima_posicion: Vector2

func _process(delta):
	var raton_posicion = get_global_mouse_position()
	if Input.is_action_just_pressed("mover_camara"):
		arrastrar_cam=true
		ultima_posicion= raton_posicion
	if Input.is_action_just_released("mover_camara"):
		arrastrar_cam=false
	if arrastrar_cam:
		var posicion_raton = ultima_posicion-raton_posicion
		position = clamp_posicion(position + posicion_raton)
		#ultima_posicion = raton_posicion

func clamp_posicion (pos: Vector2)->Vector2:
	var ventana_tamaño = get_viewport_rect().size/2*zoom
	pos.x =clamp(pos.x, limit_left + ventana_tamaño.x, limit_right-ventana_tamaño.x)
	pos.y =clamp(pos.y, limit_top + ventana_tamaño.y, limit_bottom-ventana_tamaño.y)
	return pos
