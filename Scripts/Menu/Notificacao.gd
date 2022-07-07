extends CanvasLayer

var ParametroNome = ""
var ParametroDescricao = ""
var ParametroIcone = ""

onready var indice_path = $Indice/CenterContainer/IndiceNumero

var pre_Dialogo = preload("res://Scenes/GUI/CaixaDeDialogo.tscn")

func _ready():
	
	pass

func setParametros(nome, desc, icon, quant):
	ParametroNome = nome
	ParametroDescricao = desc
	ParametroIcone = icon
	indice_path.text = quant

func _on_Button_pressed():
	var Dialogo = pre_Dialogo.instance()
	get_parent().add_child(Dialogo)
	Dialogo.setParametro(ParametroNome, ParametroDescricao, ParametroIcone)
	queue_free()
	pass
