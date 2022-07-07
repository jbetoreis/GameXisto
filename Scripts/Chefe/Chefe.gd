extends Area2D

onready var animacoes = $AnimatedSprite
var definirPos = true
var estado = "Entrar"
var estadoAnterior = ""
var spdh = 0
var start_pos = Vector2(0,0)
var distancia = 350
var escalaFixa
var tempo_tosse = 0
var framesTremor = [2,5]
var framesTosse = [1,4]
var frameAtual
var boost = false
var traumaForca = 1
var traumaDuracao = 0.5
var tempo_fala = 3
var indiceFala = 0
var ondialog = true
var Falas = ["Vem aqui, é só uma gripezinha!","Eu não tenho medo, possuo histórico de atleta","Essa máscara não vai te ajudar","Por que tanto cuidado?"]

var virus = preload("res://Scenes/Inimigos/InimigoVerde.tscn")

onready var Alvo = get_tree().get_root().get_node("Stage01/Perc")
onready var camera = get_tree().get_root().get_node("Stage01/Perc/Camera2D")
onready var cena = get_tree().get_root().get_node("Stage01")

func _ready():
	start_pos = position
	escalaFixa = scale

func _process(delta):
	var dir = position.direction_to(Alvo.position)
	var distance = position.distance_to(Alvo.position)
	var distancia_x = Vector2(position.x, 0).distance_to(Vector2(Alvo.position.x, 0))
	if !ondialog:
		tempo_fala+=delta
		if tempo_fala>=8:
			cena.MostrarFala(Falas[indiceFala], "Negacionista: ")
			if indiceFala<Falas.size()-1:	indiceFala+=1
			else:	indiceFala = 0
			tempo_fala = 0
	match estado:
		"Entrar":
			ondialog = true
			animacoes.animation = "Andando"
			animacoes.speed_scale = 1.5
			scale.x = escalaFixa.x*-1
			tempo_tosse+=delta
			if tempo_tosse>=2:
				estadoAnterior = estado
				estado = "Tossir"
				tempo_tosse = 0
			if distance>distancia:
				spdh = -2
			else:
				spdh = 0
				animacoes.animation = "Parado"
				Global.ativar = true
				cena.SomBoss()
				estado = "Esperar"
			IniciarTremor()
		"Esperar":
			
			pass
		"Parado":
			ondialog = false
			animacoes.animation = "Parado"
			spdh = 0
			if dir.x>0: scale.x = escalaFixa.x
			elif dir.x<0: scale.x = escalaFixa.x*-1
			tempo_tosse+=delta
			if tempo_tosse>=3 and distancia_x<800:
				estadoAnterior = estado
				estado = "Tossir"
				tempo_tosse = 0
			if Vector2(position.x, 0).distance_to(Vector2(Alvo.position.x, 0))>distancia:
				estado = "Seguir"
		"Seguir":
			ondialog = false
			animacoes.animation = "Andando"
			animacoes.speed_scale = 1.5
			if dir.x>0:
				spdh = 2
				scale.x = escalaFixa.x
			elif dir.x<0:
				spdh = -2
				scale.x = escalaFixa.x*-1
			tempo_tosse+=delta
			if tempo_tosse>=3 and distancia_x<800 and !boost:
				estadoAnterior = estado
				estado = "Tossir"
				tempo_tosse = 0
			if distance>1000:
				boost = true
			if boost:
				spdh*=3
				animacoes.speed_scale = 5
				if distancia_x<380:
					boost = false
					estadoAnterior = estado
					estado = "Espirrar"
			if Vector2(position.x, 0).distance_to(Vector2(Alvo.position.x, 0))<distancia:
				estado = "Parado"
			IniciarTremor()
		"Tossir":
			animacoes.animation = "Tossindo"
			animacoes.speed_scale = 1
			spdh = 0
			if animacoes.frame==4:
				estado = estadoAnterior
			if frameAtual!=animacoes.frame:
				for j in range(framesTosse.size()):
					if animacoes.frame == framesTosse[j]:
						Tossir()
			frameAtual = animacoes.frame
		"Espirrar":
			animacoes.animation = "Espirrar"
			animacoes.speed_scale = 1
			spdh = 0
			if animacoes.frame==4:
				for j in range(6):
					var posicao = $SpawnVirus.global_position
					posicao.y = (posicao.y-60)+j*20
					Espirrar(0.7, 1, -0.1*j, 0.1*j, posicao)
				estado = estadoAnterior
		"Fugir":
			ondialog = true
			animacoes.animation = "Andando"
			animacoes.speed_scale = 5
			spdh = 6
			scale.x = escalaFixa.x
			if distance>1500:
				Global.ativar = true
				cena.SomCidade()
				queue_free()
			IniciarTremor()
		"Retornar":
			ondialog = true
			animacoes.animation = "Andando"
			animacoes.speed_scale = 1.5
			if definirPos and distance>1000:
				position.x = Alvo.position.x+1000
				definirPos = false
			if distance>distancia:
				spdh = -2
				scale.x = escalaFixa.x*-1
			else:
				spdh = 0
				animacoes.animation = "Parado"
				Global.ativar = true
				estado = "Esperar"
			IniciarTremor()

	position.x+=spdh
	traumaForca = (250/distance)*abs(spdh)
	traumaDuracao = 0.25*abs(spdh)

func Tossir():
	var v = virus.instance()
	get_parent().add_child(v)
	v.position = $SpawnVirus.global_position
	v._setSpeed(500)
	v.Direcao(sign(v.scale.x*sign(scale.x)), 0.7, 1, -0.15, 0.35)
	v.intangivel()

func Espirrar(xx01,xx02,yy01,yy02, pos):
	var v = virus.instance()
	get_parent().add_child(v)
	v.position = pos
	v._setSpeed(350)
	v.Direcao(sign(v.scale.x*sign(scale.x)), xx01,xx02,yy01,yy02)
	v.intangivel()

func IniciarTremor():
	for i in range(framesTremor.size()):
		if animacoes.frame == framesTremor[i]:
			camera.setParametros(traumaForca,traumaDuracao)
			camera.Terremoto()
