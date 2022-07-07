extends Node

onready var jogador = get_node("Perc")
var dialogos = [["Preciso comprar remédios para a minha irmã.","A farmácia mais próxima está à direita.","Preciso ficar atento as pessoas sem máscara."],["Agora eu preciso voltar para casa em segurança.","......","Você parece tão preocupado com as tão faladas medidas de prevenção.", "Eu não gosto delas, não consigo imaginar onde o nosso país vai parar com todo esse mimimi!","Não entendo porque está falando isso, as práticas de prevenção são essenciais.","Venha, vou te mostrar que não precisa ter medo dessa gripezinha!"],["....","Até quando você pretende ficar em casa?","Precisamos resolver esse problema agora.","Logo você verá as consequências dessa atitude.","....","Parabéns, você concluiu os desafios propostos, continue aplicando as medidas de prevenção. Obrigado por jogar!"]]
var posicoes = [Vector2(510,664),Vector2(6104,648),Vector2(512,664)]
var icones = [["res://Assets/Perc/FotoIcon/Foto.png", "res://Assets/Perc/FotoIcon/Foto.png","res://Assets/Perc/FotoIcon/Foto.png"],["res://Assets/Perc/FotoIcon/Foto.png","res://Assets/Chefe/FotoIcon/Icon.png","res://Assets/Chefe/FotoIcon/Icon.png","res://Assets/Chefe/FotoIcon/Icon.png","res://Assets/Perc/FotoIcon/Foto.png","res://Assets/Chefe/FotoIcon/Icon.png"],["res://Assets/Chefe/FotoIcon/Icon.png","res://Assets/Chefe/FotoIcon/Icon.png","res://Assets/Chefe/FotoIcon/Icon.png","res://Assets/Chefe/FotoIcon/Icon.png","res://Assets/Chefe/FotoIcon/Icon.png","res://Assets/Interface/IconeTerra150.png"]]
var ativacao = [["enter","enter","enter"],["enter","ativacao","enter","enter","enter","enter"],["ativacao","enter","enter","enter","ativacao","enter"]]
var acao = [["nulo","nulo","mostrarTeclas"],["entrarBoss","nulo","nulo","nulo","nulo","comecarBoss"],["retornarBoss","nulo","nulo","bossFoge","nulo","nulo"]]
var indice = 0
var PedestresMax = 7

var exclamacao = preload("res://Scenes/GUI/PontoDeControle.tscn")
var boss = preload("res://Scenes/Chefe/Chefe.tscn")
var fala = preload("res://Scenes/GUI/Falas.tscn")
var pedestre = preload("res://Scenes/Pedestre/Pedestre.tscn")
var teclas = preload("res://Scenes/GUI/QuadroDeInstrucao.tscn")
var chefeCena

func _ready():
	randomize()
	ProximoDialogo()
	pass

func _process(delta):
	if get_tree().get_nodes_in_group("Pedestre").size()<PedestresMax:
		var pe = pedestre.instance()
		add_child(pe)
		var posicao = 0
		if jogador.impulsox==0:	posicao = ranges(jogador.position.x-1800, jogador.position.x+1800)
		elif jogador.impulsox>0: posicao = ranges(jogador.position.x-1200, jogador.position.x+2400)
		elif jogador.impulsox<0: posicao = ranges(jogador.position.x-2400, jogador.position.x+1200)
		pe.position = Vector2(posicao, 650)

func ranges(num01, num02):
	var resultado = 0
	var sortear = true
	while sortear:
		resultado = int(floor(rand_range(num01,num02)))
		if (resultado<jogador.position.x-650 or resultado>jogador.position.x+650):
			sortear = false
	return resultado

func ProximoDialogo():
	if indice<dialogos.size():
		var ex = exclamacao.instance()
		add_child(ex)
		ex.position = posicoes[indice]
		ex.parametros(dialogos[indice], icones[indice], ativacao[indice], acao[indice])
		indice+=1

func MostrarFala(txt, pes):
	var fa = fala.instance()
	add_child(fa)
	fa.setParametro(txt, pes)

###AcoesDialogo###
func EntrarBoss():
	$BGMCity.stop()
	var chefe = boss.instance()
	add_child(chefe)
	chefe.position = Vector2(7000,580)
	chefe.estado = "Entrar"
	chefeCena = chefe

func SomBoss():
	$BGMBoss01.play(0)

func ComecarBoss():
	chefeCena.estado = "Parado"

func RetornarBoss():
	chefeCena.estado = "Retornar"
	$BGMBoss01.stop()
	$BGMBoss01.play(3)

func BossFoge():
	chefeCena.estado = "Fugir"

func SomCidade():
	$BGMBoss01.stop()
	$BGMCity.play(0)

func MostrarTeclas():
	if Global.primeiroJogo:
		var te = teclas.instance()
		add_child(te)
		te.position = Vector2(jogador.position.x-160, 720)
		te.setParametros("res://Assets/Interface/QuadroInstrucoes.png", 300)
