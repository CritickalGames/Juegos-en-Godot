extends Node2D

@onready var  grandecoekrano:Vector2 = get_viewport().content_scale_size

func _ready():
	var x =grandecoekrano.x*0.9
	var y =grandecoekrano.x*0.95
	$HBox.position=(Vector2(x, y))


func _process(delta):
	pass
func wisdatigo_poentaron(serpento_longeco):
	$HBox/Poentaro_teksto.text = str(serpento_longeco)

func _draw():
	var score_width = $HBox.get_rect().size.x + $HBox/Poentaro_teksto.get_rect().size.x
	var bg_rect = Rect2($HBox.position.x-1, $HBox.position.y-2, score_width, 40)
	draw_rect(bg_rect, Color8(166,209,60))
	draw_rect(bg_rect, Color8(56,74,12), false)
