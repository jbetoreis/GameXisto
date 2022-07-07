extends Area2D

export var listaFalas = [""]
export var icones = [""]
export var ativacao = [""]
export var acao = [""]
var Instrucoes = preload("res://Scenes/GUI/CaixaDeObjetivo.tscn")
export var exclusao = false

func _ready():
	
	pass
	
func _on_PontoDeControle_body_entered(body):
	if body.name==("Perc") and get_tree().get_nodes_in_group("Dialogo").size()==0:
		var i = Instrucoes.instance()
		get_parent().add_child(i)
		i.setParametros(listaFalas, icones, ativacao, acao)
		if !exclusao:	get_node("/root/Stage01").ProximoDialogo()
		queue_free()

func parametros(array, icons, ativar, ac):
	listaFalas = array
	icones = icons
	ativacao = ativar
	acao = ac
