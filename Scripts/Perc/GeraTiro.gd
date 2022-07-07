extends Position2D

var GeraTiro = preload("res://Scenes/Perc/TirosPerc/TiroPerc01.tscn")
var GeraTiro2 = preload("res://Scenes/Perc/TirosPerc/TiroPerc02.tscn")
var direcaox = 1

var TempoTiro = 0

var TravaAtaque = false

var ContaTempoAtaque = false

var TipoArma = 1

func _ready():
	pass

func _physics_process(delta):
	TrocaArma()
	#BOTOES----------------------------------------
	
	var ataque = Input.is_action_pressed("atirar")
	var direita = Input.is_action_pressed("direita")
	var esquerda = Input.is_action_pressed("esquerda")
	var baixo = Input.is_action_pressed("baixo")
	
	#BOTOES----------------------------------------
	
	if esquerda:
		direcaox = -1
	if direita:
		direcaox = 1
	
	#CALIBRA POSIÇÃO-------------------------------
	
	if get_node("../").abaixado == false and get_node("../").is_on_floor() and direcaox == 1:
		position = Vector2(10.6 , -2)
	
	if get_node("../").is_on_floor() and get_node("../").abaixado == true and direcaox == 1:
		position = Vector2(2.7 , 5) 
	
	if get_node("../").is_on_floor() and get_node("../").abaixado == false and direcaox == -1:
		position = Vector2(-10.6 , -2)
	
	if get_node("../").is_on_floor() and get_node("../").abaixado == true and direcaox == -1:
		position = Vector2(-3.7 , 5) 
	
	#CALIBRA POSIÇÃO-------------------------------
	
	if ataque and TravaAtaque == false:
		ContaTempoAtaque = true
	
	if ContaTempoAtaque == true:
		TempoTiro += delta
	
	
	if TempoTiro > 0.2 and TravaAtaque == false and TipoArma == 1 and get_parent().municao > 0 :
		var tiro01 = GeraTiro.instance()
		tiro01.position = position
		tiro01.scale.x = direcaox
		TravaAtaque = true
		add_child(tiro01)
		TempoTiro = 0
		get_parent().municao -=1
		ContaTempoAtaque = false
	
	
	if TempoTiro > 0.2 and TravaAtaque == false and TipoArma == 2 and get_parent().municao > 0:
		var tiro01 = GeraTiro2.instance()
		tiro01.global_position = global_position
		tiro01.scale.x = direcaox * 4
		TravaAtaque = true
		get_node("../../").add_child(tiro01)
		TempoTiro = 0
		get_parent().municao-= 1
		ContaTempoAtaque = false
	
	if !ataque:
		TravaAtaque = false
		if TempoTiro > 0.21:
			TempoTiro = 0
			ContaTempoAtaque = false
	
	
	if TipoArma == 1:
		get_parent().get_node("Inventario/ArmaEscolhida").texture = preload("res://Assets/Perc/tiro/spray/xisto-projetil-spray 0007.png")
	
	if TipoArma == 2:
		get_parent().get_node("Inventario/ArmaEscolhida").set_texture(preload("res://Assets/Perc/tiro/spream/xisto-projetil-stream0005.png"))
	

func TrocaArma():
	if Input.is_action_just_pressed("TrocaTiro"):
		TipoArma += 1
	if TipoArma > 2:
		TipoArma = 1



