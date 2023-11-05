extends Node

# Variables y constantes
	#Variables sin declarar tipo
var a = "Lo que tú quieras guardar"
	#Variables declarando tipo simple
var b: bool
var c: int = 1
var d: float = 0.5 #float y double tienen coma
	#Variable declarando tipo "Objeto"
var e: String
var f: Array =( 
	["Éste mensaje es una variable String con la ID 0", 1, 2.0, 3, 
		["Esta es una variable de ID 0 en la variable 4",
			"Éste mensaje tiene ID 1, dentro del array de ID 4"
		],
		"Ahora les explico como funcionan los array multi dimensionales"
	])
var g: Dictionary = (
	{
		"Nombre":"Z",
		"Edad": 21,
		2: 3
	})
var h: Vector2 = Vector2(1.0,2.0)
var i: Vector3 = Vector3(1.0,2.0,3.0)
var j: Vector4 = Vector4(1,2,3,4)
	#Constantes
const ES_EXACTAMENTE_LO_MISMO: String = "La diferencia es que hay que 'instanciar' la constante"
const PI = 3.14


func sumarDosNumeros(x:int, y:int) -> int:
	return x+y

# Called when the node enters the scene tree for the first time.
func _ready():
	#Operadores matematicos
	var x = 1
	var y = 2
	var suma = sumarDosNumeros(x, y)
	suma +=x #metodo resumido
	suma = suma+x
	suma = x+suma
	var algo=sumarDosNumeros(34, 64)
	'''
	suma++ = suma+1
	suma = x++ // suma = x; x++  
	suma = ++x // x++ ; suma = x
	
	+ = sumar dos numeros
	- = restar
	* = multiplicar
	/ = dividir
	% = Modulo; el resto de una división
	4/2=2
	4%2=0
	'''
	
	print(x)
	
	# CONDICIONALES
	if (1==1): # SI tal cosa es verdadera
		print("Hola mundo")
	elif (1!=1): #else if
		print("Adiós mundo cruel")
	elif (1>1):
		print("Volví, mundo")
	elif (1<1):
		print("Me vuelvo ir, mundo cruel")
	else: # SINO es verdadera tal cosa
		print("Ya no sé que hacer de mi vida")
	# Switch, en godot es MATCH
	var variable = 0+1
	match (variable):
		1: #case 1
			pass
		2:
			pass
		3:
			pass
		_: #Por defecto; default
			pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
