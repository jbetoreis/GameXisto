extends CanvasLayer

onready var Caixa = $CorpoDaCaixa/EspacoDeExibicao/HBoxContainer/InformacoesDireita/VBoxContainer/ContainerDescricao/Descricao
onready var NomeItem = $CorpoDaCaixa/EspacoDeExibicao/HBoxContainer/InformacoesEsquerda/VBoxContainer/InformacoesEsquerda/Descricao/PanelContainer/NomeDoItem
onready var icon_path = $CorpoDaCaixa/EspacoDeExibicao/HBoxContainer/InformacoesEsquerda/VBoxContainer/InformacoesEsquerda/Descricao/Icone

func _ready():
	
	pass
	
func _process(delta):
	
	pass

func setParametro(nome, desc, icon):
	NomeItem.text = nome
	Caixa.text = desc
	icon_path.texture = load(icon)


func _on_Confirmar_button_up():
	queue_free()
