extends Area2D

var Caixa = preload("res://Scenes/GUI/QuadroDeInstrucao.tscn")
export var quadro_texture = ""
export var alturamovimento = 0

func _ready():
	pass

func _on_AtivarInstrucao_body_entered(body):
	if body.name == "Perc":
		if Global.primeiroJogo:
			var ca = Caixa.instance()
			get_parent().add_child(ca)
			ca.position = Vector2(position.x-160, 720)
			ca.setParametros(quadro_texture, alturamovimento)
			queue_free()
