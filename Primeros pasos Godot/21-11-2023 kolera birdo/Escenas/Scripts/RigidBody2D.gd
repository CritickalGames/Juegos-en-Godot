extends RigidBody2D

@export_range(1, 10000) var vida : int
var velocidad_daño: Vector2
var velocidad_angular: float
@onready var main=get_tree().get_root()
@onready var label_Vida_Propio = [
 main.get_node("Nivel1/Colisionables/Node2D/MalKorelaMalBirdo_1/RigidBody2D/Vida"),
 main.get_node("Nivel1/Colisionables/Node2D/MalKorelaMalBirdo_2/RigidBody2D/Vida"),	
]
func _integrate_forces(state):
	for i in range(0, state.get_contact_count()):
		var contacto = state.get_contact_collider_object(i)
		var velocidad_contacto = state.get_contact_collider_velocity_at_position(i)
		var L=global_position-state.get_contact_local_position(i)
		var wia_velocidad = velocidad_daño - velocidad_angular * Vector2(-L.y, L.x)
		var V = velocidad_contacto-wia_velocidad
		var masa = self.mass
		var masa_cuerpo
		if contacto is RigidBody2D: masa_cuerpo = contacto.mass
		else: masa_cuerpo=10000000000
		V = V.dot(state.get_contact_local_normal(i))*(masa_cuerpo/(masa+masa_cuerpo))
		var P=int(V)
		var daño=int(P*0.015)
		var debugear= str(
			"----Formula:DOT->",masa_cuerpo,"\n",
			state.get_contact_local_normal(i),"*",
			"(",masa_cuerpo,"/(",masa,"+",masa_cuerpo,")) = ", P,"|",daño,"|", 
			(state.get_contact_local_normal(i))*(masa_cuerpo/(masa+masa_cuerpo)),"\n")
		recibir_daño(daño, debugear)
		break

func _physics_process(delta):
	velocidad_daño= linear_velocity
	velocidad_angular=angular_velocity

func _on_body_entered(body:Node):
	pass

func  recibir_daño(cant: float, debugear):
	cant = round(cant)
	if cant>0:
		#if cant>0 : print(vida, "-", cant, "=",vida-cant)
		var label_Vida = main.get_node("Nivel1/HBox/Vida")
		var label_Debug = main.get_node("Nivel1/HBox/Debug")
		if label_Vida:
			label_Vida.text +=str(vida, "-", cant, "=",vida-cant,"\n")
			label_Debug.text +=str(debugear)
		else:
			print(main)
			print(label_Vida)
		vida -= cant
	if vida<= 0:
		queue_free()
		#print("Eliminado por daño:", cant)
	$Vida.text=str(vida)

func _ready():
	print_paths(get_tree().get_root(), NodePath(""))
	pass

func print_paths(node, parent_path):
	var current_path = str(parent_path)
	print(current_path)

	for child in node.get_children():
		print_paths(child, str(current_path,"//",(child.get_name())))
