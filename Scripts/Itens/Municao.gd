extends Node2D

var tempo = 0
var coletado = false
var pre_notificacao = preload("res://Scenes/GUI/Notificacao.tscn")

#### Descrição do Item
var Nome = "Álcool"
var Descricao = "Você pode utilizar as bolsas de álcool para eliminar o vírus e se proteger, cada bolsa dispões de 5 cargas, use o com frequência."
var icone = "res://Assets/Interface/IconeAlcool.png"

func _ready():
	
	pass

func _physics_process(delta):
	
	if coletado == true:
		tempo += delta
	
	if tempo > 1:
		queue_free()
	

func _on_Detector_body_entered(body):
	if coletado == false:
		if body.name == ("Perc"):
			coletado = true
			body.municao += 5
			if body.Alcool == false and Global.primeiroJogo:
				var notificacao = pre_notificacao.instance();
				get_tree().get_root().add_child(notificacao)
				var quantidade = String(get_tree().get_nodes_in_group("Mensagem").size())
				notificacao.setParametros(Nome, Descricao, icone, quantidade)
				body.Alcool = true
			hide()
	pass
