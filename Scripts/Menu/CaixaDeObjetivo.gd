extends CanvasLayer

onready var campo = $PanelContainer/HBoxContainer/MarginContainer/VBoxContainer/Mensagem
onready var imagem = $PanelContainer/HBoxContainer/CenterContainer/Icone
var listaFalas
var iconList
var listaAtivacao
var listaAcao
var i = 0
var j = 0
var primeiraExecucao = true
onready var cenario = get_tree().get_root().get_node("Stage01")

func _ready():
	Global.pauseDialog = true
	pass

func _process(delta):
	var enter = Input.is_action_just_pressed("ui_accept")
	if j<listaAtivacao.size():
		if listaAtivacao[j]=="enter":
			if enter:
				nextDialog()
				executarAcao(j)
				j+=1
		elif listaAtivacao[j]=="ativacao":
			if j == 0 and primeiraExecucao:
				executarAcao(j)
				primeiraExecucao = false
			if Global.ativar:
				Global.ativar = false
				nextDialog()
				if j>0:
					executarAcao(j)
				j+=1

func setParametros(list, icons, ativ, acao):
	listaFalas = list
	iconList = icons
	listaAtivacao = ativ
	listaAcao = acao
	imagem.texture = load(iconList[0])
	campo.text = listaFalas[0]

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Fechar":
		Global.pauseDialog = false
		queue_free()

func nextDialog():
	if i<listaFalas.size()-1:
		i+=1
		campo.text = listaFalas[i]
		imagem.texture = load(iconList[i])
	else:	$AnimationPlayer.play("Fechar")

func executarAcao(indice):
	match listaAcao[indice]:
		"nulo":
			pass
		"entrarBoss":
			cenario.EntrarBoss()
		"comecarBoss":
			cenario.ComecarBoss()
		"retornarBoss":
			cenario.RetornarBoss()
		"bossFoge":
			cenario.BossFoge()
		"mostrarTeclas":
			cenario.MostrarTeclas()
