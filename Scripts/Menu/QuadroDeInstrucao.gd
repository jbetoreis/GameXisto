extends Node2D

var passo = "passo1"
var start_pos = Vector2(0,0)
var sair = false
onready var imagem = $Texture
var alturamovimento = 250

func _ready():
	pass

func _process(delta):
	if position.y>start_pos.y-alturamovimento:
		position.y-=15
	if sair:
		if position.y<1000:
			position.y+=30
		else:
			queue_free()

func setParametros(textura, altura):
	start_pos = position
	imagem.texture = load(textura)
	alturamovimento = altura

func _on_TempoTela_timeout():
	sair = true

func _on_Fechar_button_up():
	sair = true
