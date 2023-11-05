extends CharacterBody2D


@export var rapidecon : float 
const E = 2.71828
func _ready():
	$Animaciones.play("wiuwiu")
	var a = (sqrt(27))
	print(f(a))

func f(x):
	var f = x-5
	var g = (x**2)-25
	return (E**f)/g  


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ktrl_movado()

func ktrl_movado() -> void:
	velocity.x =  MOVIMIENTO.get_akso().x * rapidecon
	velocity.y =  MOVIMIENTO.get_akso().y * rapidecon
	move_and_slide()
