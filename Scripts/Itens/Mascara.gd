extends Node2D

var pre_notificacao = preload("res://Scenes/GUI/Notificacao.tscn")

#### Descrição do Item
var Nome = "Máscara"
var Descricao = "A máscara fornece grande proteção contra a alta disseminação do vírus, use a sempre em ambientes externos ou quando estiver na presença de outras pessoas."
var icone = "res://Assets/Interface/IconeMascara.png"

func _ready():
	pass


func _on_Detector_body_entered(body):
	if body.name == ("Perc"):
		body.mascarado = true
		if body.Mascara == false and Global.primeiroJogo:
			var notificacao = pre_notificacao.instance();
			get_tree().get_root().add_child(notificacao)
			var quantidade = String(get_tree().get_nodes_in_group("Mensagem").size())
			notificacao.setParametros(Nome, Descricao, icone, quantidade)
			body.Mascara = true
		queue_free()
	pass # Replace with function body.
