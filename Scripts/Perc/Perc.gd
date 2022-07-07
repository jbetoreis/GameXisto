extends KinematicBody2D

var velx = 3
var spdh = 0
var impulsox = 0
var direcaox = 1
var AumentaVel = 0

var armado = false
var mascarado = false
var pulando = false
var TempoPulo = 0
var ContaTempoPulo = false

var abaixado = false
var TempoAbaixado = 0

var gravidade = 300
var impulsoy = 0

var atirando = false
var TempoTiro = 0
var municao = 0

var QuantidadePulos = 2

var Chao = Vector2(0,-1)


var dano = false

var morto = false
var TempoMorte = 0

var velplatax = 0
var velplatay = 0
var Alcool = false
var Mascara = false

func _ready():
	
	pass 

var VelxPlat = 0
var VelyPlat = 0

func _physics_process(delta):
	move_local_x(velplatax)
	#SEGUE PLAT MOVEL---------------------------
	move_local_x(VelxPlat)
	move_local_y(VelyPlat)
	#SEGUE PLAT MOVEL---------------------------
	
	#LABELS----------------------------------------
	$Inventario/LabelMunicao.set_text(str(municao))
	#LABELS----------------------------------------
	#BOTOES-----------------------
	var direita = Input.is_action_pressed("direita") and (TempoAbaixado == 0 or TempoAbaixado > 0.2) and morto == false and !Global.pauseDialog
	var esquerda = Input.is_action_pressed("esquerda") and (TempoAbaixado == 0 or TempoAbaixado > 0.2) and morto == false and !Global.pauseDialog
	var baixo = Input.is_action_pressed("baixo") and morto == false and !Global.pauseDialog
	var cima = Input.is_action_pressed("cima") and morto == false and !Global.pauseDialog
	var pulo = Input.is_action_just_pressed("pulo") and morto == false and !Global.pauseDialog
	var correr = Input.is_action_pressed("correr") and !abaixado and morto == false and !Global.pauseDialog
	var atirar = Input.is_action_just_pressed("atirar") and morto == false and !Global.pauseDialog

	#BOTOES-----------------------
	#GRAVIDADE---------------------------------------------
	impulsoy += delta * 3
	if impulsoy > 1:
		impulsoy = 1
	
	if is_on_floor() and impulsoy > 0:
		impulsoy = 0
		QuantidadePulos = 1
	
	move_and_slide(Vector2(0, gravidade * impulsoy), Chao)
	#GRAVIDADE---------------------------------------------
	
	#MOVIMENTAÇÃO------------------------------------------
	if direita:
		impulsox += delta * 4
		direcaox = 1
	if esquerda:
		direcaox = -1
		impulsox -= delta * 4
	
	if impulsox > 0 and !direita:
		impulsox -= delta * 4
	if impulsox < 0 and !esquerda:
		impulsox += delta * 4
	
	if impulsox < 0.2 and impulsox > -0.2 and !(direita or esquerda):
		impulsox = 0
	
	if impulsox > 1:
		impulsox = 1
	if impulsox < -1:
		impulsox = -1
	
	if correr:
		AumentaVel = 0.5
	if !correr:
		AumentaVel = 0
	
	move_local_x(impulsox * velx + (2 * AumentaVel * velx * impulsox))
	#MOVIMENTAÇÃO------------------------------------------
	
	#PULO-------------------------------------------
	if pulo and abaixado == false:
		ContaTempoPulo = true
	if ContaTempoPulo == true:
		TempoPulo += delta
	
	if TempoPulo > 0.1 and TempoPulo <0.11 and is_on_floor():
		impulsoy = - 1.2 - AumentaVel
	
	if !is_on_floor():
		pulando = true
	if is_on_floor():
		pulando = false
	
	if is_on_floor() and impulsoy > 0:
		ContaTempoPulo = false
		TempoPulo = 0
	
	#PULO-------------------------------------------
	#ABAIXAR----------------------------------------

	if baixo and is_on_floor():
		abaixado = true
		TempoAbaixado += delta
		velx = 1
		$Shape01.position = Vector2(-4,7.5)
		$Shape01.scale = Vector2(1,0.5)
	
	
	
	if !baixo:
		$Shape01.position = Vector2(-4,-.3)
		$Shape01.scale = Vector2(1,1)
		abaixado = false
		TempoAbaixado = 0
		velx = 3
		
	
	#ABAIXAR----------------------------------------
	
	#ATIRAR----------------------------------------
	if atirar:
		if municao>0:
			$AudioSpray.set_pitch_scale(1.4)
			$AudioSpray.set_volume_db(-5)
			$AudioSpray.play(0.4)
		atirando = true
	if atirando:
		TempoTiro += delta
	if TempoTiro > 0.4:
		atirando = false
		TempoTiro = 0
	
	if is_on_floor() and atirando == true:
		impulsox = 0
	#ATIRAR----------------------------------------
	
	#ANIMACAO-----------------------------------------
	
	#COM MASCARA--------------------------
	if mascarado == true:
		
		#Parado
		if !direita and !esquerda and pulando == false and direcaox == 1 and abaixado == false and atirando == false:
			$Animacao.play("ParadoComMascara")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		
		if !direita and !esquerda and pulando == false and direcaox == -1 and is_on_floor() and abaixado == false and atirando == false:
			$Animacao.play("ParadoComMascara")
			$Sprite.scale.x = -1
			$Sprite.position.x = -8
		#Parado
		
		#Andando
		if direita and pulando == false and !correr and is_on_floor() and abaixado == false and atirando == false:
			$Animacao.play("AndandoComMascara")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		if esquerda and pulando == false and !correr and is_on_floor()and abaixado == false and atirando == false:
			$Animacao.play("AndandoComMascara")
			$Sprite.scale.x = -1
			$Sprite.position.x = -8
		#Andando
		
		#Correndo
		if direita and pulando == false and correr and abaixado == false and atirando == false:
			$Animacao.play("CorrendoComMascara")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		if esquerda and pulando == false and correr and abaixado == false and atirando == false:
			$Animacao.play("CorrendoComMascara")
			$Sprite.scale.x = -1
			$Sprite.position.x = -8
		#Correndo
		
		
		#Pular
		if TempoPulo > 0 and TempoPulo < 0.2 and is_on_floor() and direcaox == 1 and abaixado == false:
			$Animacao.play("IniciandoPuloComMascara")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		if !is_on_floor() and direcaox == 1 and pulando == true and impulsoy < 0 and abaixado == false and atirando == false:
			$Animacao.play("PulandoComMascara")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		if !is_on_floor() and direcaox == 1 and pulando == true and impulsoy >= 0 and abaixado == false and atirando == false:
			$Animacao.play("CaindoComMascara")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		
		if !is_on_floor() and direcaox == 1 and pulando == true and impulsoy < 0 and abaixado == false and atirando == true:
			$Animacao.play("PulandoComArmaComMascaraDireita")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		if !is_on_floor() and direcaox == 1 and pulando == true and impulsoy >= 0 and abaixado == false and atirando == true:
			$Animacao.play("CaindoComArmaComMascaraDireita")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		
		if TempoPulo > 0 and TempoPulo < 0.2 and is_on_floor() and direcaox == -1 and abaixado == false:
			$Animacao.play("IniciandoPuloComMascara")
			$Sprite.scale.x = -1
			$Sprite.position.x = -8
		if !is_on_floor() and direcaox == -1 and pulando == true and impulsoy < 0 and abaixado == false and atirando == false:
			$Animacao.play("PulandoComMascara")
			$Sprite.scale.x = -1
			$Sprite.position.x = -8
		if !is_on_floor() and direcaox == -1 and pulando == true and impulsoy >= 0 and abaixado == false and atirando == false:
			$Animacao.play("CaindoComMascara")
			$Sprite.scale.x = -1
			$Sprite.position.x = -8
		
		if !is_on_floor() and direcaox == -1 and pulando == true and impulsoy < 0 and abaixado == false and atirando == true:
			$Animacao.play("PulandoComArmaComMascaraEsquerda")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		if !is_on_floor() and direcaox == -1 and pulando == true and impulsoy >= 0 and abaixado == false and atirando == true:
			$Animacao.play("CaindoComArmaComMascaraEsquerda")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		#Pular
		
		#Abaixar
		
		if TempoAbaixado > 0 and TempoAbaixado < 0.2 and is_on_floor() and direcaox == 1 and atirando == false:
			$Animacao.play("AgaixandoComMascara")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		
		if TempoAbaixado > 0.2 and is_on_floor() and direcaox == 1 and !direita and !esquerda and atirando == false:
			$Animacao.play("AgaixadoComMascara")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		
		if TempoAbaixado > 0 and TempoAbaixado < 0.2 and is_on_floor() and direcaox == -1 and atirando == false:
			$Animacao.play("AgaixandoComMascara")
			$Sprite.scale.x = -1
			$Sprite.position.x = -8
		
		if TempoAbaixado > 0.2 and is_on_floor() and direcaox == -1 and !direita and !esquerda and atirando == false:
			$Animacao.play("AgaixadoComMascara")
			$Sprite.scale.x = -1
			$Sprite.position.x = -8
		
		if baixo and direita and TempoAbaixado > 0.2 and atirando == false:
			$Animacao.play("ArrastandoComMascara")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		if baixo and esquerda and TempoAbaixado > 0.2 and atirando == false:
			$Animacao.play("ArrastandoComMascara")
			$Sprite.scale.x = -1
			$Sprite.position.x = -8
		#Abaixar
		
		#Atirar
		if atirando and is_on_floor() and direcaox == 1 and !baixo:
			$Animacao.play("AtacandoComMascaraDireita")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		if atirando and is_on_floor() and direcaox == -1 and !baixo:
			$Animacao.play("AtacandoComMascaraEsquerda")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		
		if atirando and is_on_floor() and direcaox == 1 and baixo:
			$Animacao.play("AtacandoComMascaraAbaixadoDireita")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		if atirando and is_on_floor() and direcaox == -1 and baixo:
			$Animacao.play("AtacandoComMascaraAbaixadoEsquerda")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		#Atirar
	#COM MASCARA--------------------------
	
	#SEM MASCARA-------------------------------------
	
	if mascarado == false and morto == false:
		if !direita and !esquerda and pulando == false and direcaox == 1 and abaixado == false and atirando == false:
			$Animacao.play("ParadoSemMascara")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		
		if !direita and !esquerda and pulando == false and direcaox == -1 and is_on_floor() and abaixado == false and atirando == false:
			$Animacao.play("ParadoSemMascara")
			$Sprite.scale.x = -1
			$Sprite.position.x = -8
		#Parado
		
		#Andando
		if direita and pulando == false and !correr and is_on_floor() and abaixado == false and atirando == false:
			$Animacao.play("AndandoSemMascara")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		if esquerda and pulando == false and !correr and is_on_floor()and abaixado == false and atirando == false:
			$Animacao.play("AndandoSemMascara")
			$Sprite.scale.x = -1
			$Sprite.position.x = -8
		#Andando
		
	#Correndo
		if direita and pulando == false and correr and abaixado == false and atirando == false:
			$Animacao.play("CorrendoSemMascara")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		if esquerda and pulando == false and correr and abaixado == false and atirando == false:
			$Animacao.play("CorrendoSemMascara")
			$Sprite.scale.x = -1
			$Sprite.position.x = -8
		#Correndo
		
		
		#Pular
		if TempoPulo > 0 and TempoPulo < 0.2 and is_on_floor() and direcaox == 1 and abaixado == false:
			$Animacao.play("IniciandoPuloSemMascara")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		if !is_on_floor() and direcaox == 1 and pulando == true and impulsoy < 0 and abaixado == false and atirando == false:
			$Animacao.play("PulandoSemMascara")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		if !is_on_floor() and direcaox == 1 and pulando == true and impulsoy >= 0 and abaixado == false and atirando == false:
			$Animacao.play("CaindoSemMascara")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		
		if !is_on_floor() and direcaox == 1 and pulando == true and impulsoy < 0 and abaixado == false and atirando == true:
			$Animacao.play("PulandoComArmaSemMascaraDireita")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		if !is_on_floor() and direcaox == 1 and pulando == true and impulsoy >= 0 and abaixado == false and atirando == true:
			$Animacao.play("CaindoComArmaSemMascaraDireita")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		
		if TempoPulo > 0 and TempoPulo < 0.2 and is_on_floor() and direcaox == -1 and abaixado == false:
			$Animacao.play("IniciandoPuloSemMascara")
			$Sprite.scale.x = -1
			$Sprite.position.x = -8
		if !is_on_floor() and direcaox == -1 and pulando == true and impulsoy < 0 and abaixado == false and atirando == false:
			$Animacao.play("PulandoSemMascara")
			$Sprite.scale.x = -1
			$Sprite.position.x = -8
		if !is_on_floor() and direcaox == -1 and pulando == true and impulsoy >= 0 and abaixado == false and atirando == false:
			$Animacao.play("CaindoSemMascara")
			$Sprite.scale.x = -1
			$Sprite.position.x = -8
		
		if !is_on_floor() and direcaox == -1 and pulando == true and impulsoy < 0 and abaixado == false and atirando == true:
			$Animacao.play("PulandoComArmaSemMascaraEsquerda")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		if !is_on_floor() and direcaox == -1 and pulando == true and impulsoy >= 0 and abaixado == false and atirando == true:
			$Animacao.play("CaindoComArmaSemMascaraEsquerda")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		#Pular
		
		#Abaixar
		
		if TempoAbaixado > 0 and TempoAbaixado < 0.2 and is_on_floor() and direcaox == 1 and atirando == false:
			$Animacao.play("AgaixandoSemMascara")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		
		if TempoAbaixado > 0.2 and is_on_floor() and direcaox == 1 and !direita and !esquerda and atirando == false:
			$Animacao.play("AgaixadoSemMascara")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		
		if TempoAbaixado > 0 and TempoAbaixado < 0.2 and is_on_floor() and direcaox == -1 and atirando == false:
			$Animacao.play("AgaixandoSemMascara")
			$Sprite.scale.x = -1
			$Sprite.position.x = -8
		
		if TempoAbaixado > 0.2 and is_on_floor() and direcaox == -1 and !direita and !esquerda and atirando == false:
			$Animacao.play("AgaixadoSemMascara")
			$Sprite.scale.x = -1
			$Sprite.position.x = -8
		
		if baixo and direita and TempoAbaixado > 0.2 and atirando == false:
			$Animacao.play("ArrastandoSemMascara")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		if baixo and esquerda and TempoAbaixado > 0.2 and atirando == false:
			$Animacao.play("ArrastandoSemMascara")
			$Sprite.scale.x = -1
			$Sprite.position.x = -8
		#Abaixar
		
		#Atirar
		if atirando and is_on_floor() and direcaox == 1 and !baixo:
			$Animacao.play("AtacandoSemMascaraDireita")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		if atirando and is_on_floor() and direcaox == -1 and !baixo:
			$Animacao.play("AtacandoSemMascaraEsquerda")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		
		if atirando and is_on_floor() and direcaox == 1 and baixo:
			$Animacao.play("AtacandoSemMascaraAbaixadoDireita")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		if atirando and is_on_floor() and direcaox == -1 and baixo:
			$Animacao.play("AtacandoSemMascaraAbaixadoEsquerda")
			$Sprite.scale.x = 1
			$Sprite.position.x = 0
		
	#SEM MASCARA-------------------------------------
	
	#ANIMACAO-----------------------------------------
	AfastaParede()
	Dano(delta)
	

func AfastaParede():
	if $RayDireita.is_colliding() and direcaox == 1 :
		velx = 0
		AumentaVel = 0
	
	if $RayEsquerda.is_colliding() and direcaox == -1 :
		velx = 0
		AumentaVel = 0

func Dano(delta):
	if dano == true and mascarado == true:
		dano = false
		mascarado = false
		impulsoy = -0.7
	
	if dano == true and mascarado == false:
		morto = true
	
	if morto == true:
		TempoMorte += delta
	
	if TempoMorte > 0 and TempoMorte < 1.1:
		if direcaox == 1:
			$Animacao.play("MorrendoDireita")
		if direcaox == -1:
			$Animacao.play("MorrendoEsquerda")
	if TempoMorte > 1.1:
		if direcaox == 1:
			$Animacao.play("MortoDireita")
		if direcaox == -1:
			$Animacao.play("MortoEsquerda")
	
	if TempoMorte > 1.8:
		##get_tree().change_scene("res://Scenes/Menu/Menu.tscn")
		##get_tree().change_scene("res://Scenes/Stages/Stage01.tscn")
		var itens = get_tree().get_nodes_in_group("GUI")
		for i in range(get_tree().get_nodes_in_group("GUI").size()):
			itens[i].queue_free()
		Global.primeiroJogo = false
		get_tree().reload_current_scene()
	
