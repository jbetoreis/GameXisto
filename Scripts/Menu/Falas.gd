extends CanvasLayer

onready var NodeFala = $CenterContainer/HBoxContainer/Fala
onready var NodePessoa = $CenterContainer/HBoxContainer/Pessoa

func _ready():
	pass

func _process(delta):
	if Global.pauseDialog:
		queue_free()

func setParametro(text, pessoa):
	NodeFala.text = text
	NodePessoa.text = pessoa

func _on_TempoTela_timeout():
	queue_free()
