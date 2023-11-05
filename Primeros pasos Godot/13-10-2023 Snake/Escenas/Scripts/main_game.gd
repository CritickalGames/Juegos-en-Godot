extends Node

const SERPENTO = 0
const POMO = 1
const EKRANLIMO = 19

const DEKSTRA: Vector2 = Vector2(1,0)
const MALDEKSTRA: Vector2= Vector2(-1,0)
const SUPRO: Vector2= Vector2(0,-1)
const MALSUPRO: Vector2= Vector2(0,1)

var pomo_poz: Vector2
var serpento_korpo_komenca: Array[Vector2]= [Vector2(5,10), Vector2(4,10), Vector2(3,10) ]
var serpento_korpo: Array[Vector2]= serpento_korpo_komenca
var serpento_direkto: Vector2 = Vector2(1,0)
var aldonis_pomon: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pomo_poz = meti_pomon()

func _process(delta):
	kontroli_ludo_finita()

func _input(event):
	var kapo_direkto = rilato2(serpento_korpo[0], serpento_korpo[1])
	match MOVI.get_axis():#Akso akiras la direkton de la sagoj, do supro estas malsupro
		SUPRO: #MalSupro
			if not kapo_direkto==SUPRO:
				serpento_direkto = MALSUPRO
		MALSUPRO:#Supro
			if not kapo_direkto==MALSUPRO:
				serpento_direkto = SUPRO
		DEKSTRA:
			if not kapo_direkto==MALDEKSTRA:
				serpento_direkto = DEKSTRA
		MALDEKSTRA:
			if not kapo_direkto==DEKSTRA:
				serpento_direkto = MALDEKSTRA

#_input
func rilato2(la_pli_proksime_al_la_kapo_bloko:Vector2, la_pli_proksime_al_la_vosto_bloko:Vector2):
	var bloko_rilato = la_pli_proksime_al_la_kapo_bloko - la_pli_proksime_al_la_vosto_bloko
	return bloko_rilato

func _on_serpento_tiktako_timeout():
	kreskas_serpento()
	desegni_pomon()
	desegni_serpenton()
	kontroli_pomon_manwita()

func kreskas_serpento():
	if aldonis_pomon:
		translokiwi_serpenton(0)
		aldonis_pomon=false
	else:
		translokiwi_serpenton(1)

#Kreskas
func translokiwi_serpenton(kresko:int):
	forigi_kahelon(SERPENTO)
	var korpo_kopio = serpento_korpo.slice(0, serpento_korpo.size()-kresko)
	var nova_kapo = korpo_kopio[0] + serpento_direkto
	korpo_kopio.insert(0, nova_kapo)
	serpento_korpo = korpo_kopio

#translokiwi
func forigi_kahelon(id:int):
	var xeloj = $SerpentoPomo.get_used_cells_by_id(id)
	for xelo in xeloj:
		var koordinato: Vector2 = Vector2(xelo.x,xelo.y)
		var atlas: Vector2 = Vector2(8,0)
		$SerpentoPomo.set_cell(0, koordinato, SERPENTO, atlas)

func desegni_pomon():
	var koordinato: Vector2i= Vector2i(pomo_poz.x,pomo_poz.y)
	var atlas: Vector2i= Vector2i(0,0)
	$SerpentoPomo.set_cell(0,koordinato, POMO, atlas)

func desegni_serpenton():
	for bloko_indekso in serpento_korpo.size():
		var bloko_aktuala = serpento_korpo[bloko_indekso]
		var koordinato: Vector2i= Vector2i(bloko_aktuala.x, bloko_aktuala.y)
		if bloko_indekso == 0:
			desegni_kapo(bloko_aktuala, koordinato)
		elif bloko_indekso == serpento_korpo.size()-1:
			desegni_vosto(bloko_aktuala,koordinato)
		else:
			desegni_korpo(bloko_aktuala, koordinato, bloko_indekso)

#Desegni_serpenton
func direkto(la_pli_proksime_al_la_kapo_bloko:Vector2, la_pli_proksime_al_la_vosto_bloko:Vector2):
	var bloko_direkto = la_pli_proksime_al_la_kapo_bloko - la_pli_proksime_al_la_vosto_bloko
	if bloko_direkto == Vector2(-1,0): return 'maldekstra'
	if bloko_direkto == Vector2(1,0): return 'dekstra'
	if bloko_direkto == Vector2(0,1): return 'malsupro'
	if bloko_direkto == Vector2(0,-1): return 'supro'

#Desegni_serpenton
func desegni_kapo(koordinato, bloko_aktuala):
	#La nomo rilatas al la direkto en kiu rigardas la okulojn.
	var kapo_direkto = direkto(serpento_korpo[0], serpento_korpo[1])
	var kapo_dekstra: Vector2i = Vector2i(2,0)
	var kapo_maldekstra: Vector2i = Vector2i(3,1)
	var kapo_supro: Vector2i = Vector2i(2,1)
	var kapo_malsupro: Vector2i = Vector2i(3,0)

	if kapo_direkto == 'dekstra':
		$SerpentoPomo.set_cell(0, koordinato, SERPENTO, kapo_dekstra)
	if kapo_direkto == 'maldekstra':
		$SerpentoPomo.set_cell(0, koordinato, SERPENTO, kapo_maldekstra)
	if kapo_direkto == 'supro':
		$SerpentoPomo.set_cell(0, koordinato, SERPENTO, kapo_supro)
	if kapo_direkto == 'malsupro':
		$SerpentoPomo.set_cell(0, koordinato, SERPENTO, kapo_malsupro)

#Desegni_serpenton
func desegni_vosto(bloko_aktuala, koordinato):
	var vosto_direkto = direkto(serpento_korpo[-2], serpento_korpo[-1])
	
	#La nomo rilatas al la direkto en kiu rigardas la okulojn.
	var vosto_dekstra: Vector2i = Vector2i(0,0)
	var vosto_maldekstra: Vector2i = Vector2i(1,0)
	var vosto_supro: Vector2i = Vector2i(1,1)
	var vosto_malsupro: Vector2i = Vector2i(0,1)
	
	if vosto_direkto == 'dekstra':
		$SerpentoPomo.set_cell(0, koordinato, SERPENTO, vosto_dekstra)
	if vosto_direkto == 'maldekstra':
		$SerpentoPomo.set_cell(0, koordinato, SERPENTO, vosto_maldekstra)
	if vosto_direkto == 'supro':
		$SerpentoPomo.set_cell(0, koordinato, SERPENTO, vosto_supro)
	if vosto_direkto == 'malsupro':
		$SerpentoPomo.set_cell(0, koordinato, SERPENTO, vosto_malsupro)

#Desegni_serpenton
func desegni_korpo(bloko_aktuala, koordinato, bloko_indekso):
	var antaya_bloko = serpento_korpo[bloko_indekso + 1] - bloko_aktuala
	var sekva_bloko = serpento_korpo[bloko_indekso - 1] - bloko_aktuala
	
	var korpo_vertikala: Vector2i = Vector2i(4,1)
	var korpo_horizontala: Vector2i = Vector2i(4,0)
	
	#La nomo rilatas al la koordinatoj xe la if
	var korpo_dekstra_malsupro: Vector2i = Vector2i(5,0)
	var korpo_dekstra_supro: Vector2i = Vector2i(5,1)
	var korpo_maldekstra_malsupro: Vector2i = Vector2i(6,0)
	var korpo_maldekstra_supro: Vector2i = Vector2i(6,1)
	
	var x: int = 1 # X Dekstra
	var malx: int = -1
	var y: int = x # Y Malsupro
	var maly: int = malx
	
	if antaya_bloko.x == sekva_bloko.x:
		$SerpentoPomo.set_cell(0, koordinato, SERPENTO, korpo_vertikala)
	elif antaya_bloko.y == sekva_bloko.y:
		$SerpentoPomo.set_cell(0, koordinato, SERPENTO, korpo_horizontala)
	else:
		if (antaya_bloko.x == malx and sekva_bloko.y == maly or
		sekva_bloko.x == malx and antaya_bloko.y == maly):
			$SerpentoPomo.set_cell(0, koordinato, SERPENTO, korpo_maldekstra_supro)
		if (antaya_bloko.x == malx and sekva_bloko.y == y or 
		sekva_bloko.x == malx and antaya_bloko.y == y):
			$SerpentoPomo.set_cell(0, koordinato, SERPENTO, korpo_maldekstra_malsupro)
		if (antaya_bloko.x == x and sekva_bloko.y == maly or
		sekva_bloko.x == x and antaya_bloko.y == maly):
			$SerpentoPomo.set_cell(0, koordinato, SERPENTO, korpo_dekstra_supro)
		if (antaya_bloko.x == x and sekva_bloko.y == y or
		sekva_bloko.x == x and antaya_bloko.y == y):
			$SerpentoPomo.set_cell(0, koordinato, SERPENTO, korpo_dekstra_malsupro)

func kontroli_pomon_manwita():
	if pomo_poz == serpento_korpo[0]:
		pomo_poz = meti_pomon()
		aldonis_pomon = true
		get_tree().call_group('grupo poentaro', 'wisdatigo_poentaron', serpento_korpo.size()-2)
		$KrakaSono.play()
		if pomo_poz in serpento_korpo:
			pomo_poz = meti_pomon()

#Kontroli_pomon_manwita()
func meti_pomon():
	randomize()
	var x = randi()%20
	var y = randi()%20
	return Vector2(x,y)

#_process
func kontroli_ludo_finita():
	var kapo = serpento_korpo[0]
	#Serpento eliras la ekrano
	if kapo.x > EKRANLIMO or kapo.x < 0 or kapo.y < 0 or kapo.y > EKRANLIMO:
		restarigi()
	
	for bloko in serpento_korpo.slice(1, serpento_korpo.size()-1):
		if bloko == kapo:
			restarigi()

#Kontroli_Ludo_finita
func restarigi():
	serpento_korpo = serpento_korpo_komenca
	serpento_direkto = Vector2(1,0)
	get_tree().call_group('grupo poentaro', 'wisdatigo_poentaron', 0)


