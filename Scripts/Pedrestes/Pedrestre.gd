extends Area2D

var Mascarado = false
var infectado = false
var Virus = preload("res://Scenes/Inimigos/InimigoVerde.tscn")
var Goticulas = preload("res://Scenes/Pedestre/Goticulas.tscn")
var estado = "Andando"
var spdh = 0
var speed = 1.5
var ocupando = false
var distanciarender = 0
onready var Anim = $Animacao
onready var Jogador = get_tree().get_root().get_node("Stage01/Perc")

func _ready():
	randomize()
	var r = rand_range(0,5)
	var s = randi() % 2
	var i = randi() % 2	#Infectado ou não
	speed = rand_range(1.2, 1.8)
	#Infectado
	if i:
		infectado = true
		$IconeInfectado.visible = true
	else:
		infectado = false
		$IconeInfectado.visible = false
	#Scale x randi
	if s:	scale.x = scale.x
	else:	scale.x*=-1
	#Máscara
	if r < 3.25:   ##Sem Mascara
		Mascarado = false
	elif r > 3.25:   #Com Mascara
		Mascarado = true
	$Spawner.wait_time = rand_range(4,6)
	$BalaoFalando.wait_time = $Spawner.wait_time-1.5
	$BalaoFalando.start()
	$Spawner.start()

func _process(delta):
	var dir = position.direction_to(Jogador.position)
	var distance = Vector2(position.x, 0).distance_to(Vector2(Jogador.position.x, 0))
	if Jogador.impulsox==0:	
		distanciarender = 2000
	elif Jogador.impulsox>0:	
		if dir.x<0:
			distanciarender = 2600
		if dir.x>0:
			distanciarender = 1400
	elif Jogador.impulsox<0:
		if dir.x>0:
			distanciarender = 2600
		if dir.x<0:
			distanciarender = 1400
	if distance>distanciarender:
		queue_free()
	
	match estado:
		"Parado":
			if Mascarado:	Anim.animation = "ParadoMascara"
			else:	Anim.animation = "Parado"
			Anim.speed_scale = 1
			spdh = 0
		"Andando":
			if Mascarado:	Anim.animation = "AndandoMascara"
			else:	Anim.animation = "Andando"
			Anim.speed_scale = 0.8+speed/4
			spdh = speed*sign(scale.x)
	position.x+=spdh

func _on_Spawner_timeout():
	if !Mascarado and infectado:
		var v = Virus.instance()
		get_parent().add_child(v)
		v.position = $PontoDeSpawn.global_position
		v.Direcao(sign(v.scale.x*sign(scale.x)), 0.5, 1, -0.35, 0.35)
		v.intangivel()
	if !Mascarado:
		var g = Goticulas.instance()
		add_child(g)
		g.global_position = Vector2($PontoDeSpawn.global_position.x+sign(scale.x)*10,$PontoDeSpawn.global_position.y)
	$Spawner.wait_time = rand_range(4,6)
	$Spawner.start()
	$PanelContainer.visible = false
	$BalaoFalando.wait_time = $Spawner.wait_time-1
	$BalaoFalando.start()

func _on_BalaoFalando_timeout():
	$PanelContainer.visible = true

func _on_Pedestre_area_entered(area):
	if area.is_in_group("EspacoCotidiano"):
		if !area.ocupado:
			area.ocupado = true
			ocupando = true
			$TempoParado.start()
			estado = "Parado"
	if area.is_in_group("AreaSegura"):
		$Spawner.stop()
		$BalaoFalando.stop()
		$PanelContainer.visible = false

func _on_Pedestre_area_exited(area):
	if area.is_in_group("EspacoCotidiano"):
		if area.ocupado and ocupando:
			area.ocupado = false
			ocupando = false
	if area.is_in_group("AreaSegura"):
		$Spawner.wait_time = rand_range(3,5)
		$BalaoFalando.wait_time = $Spawner.wait_time-1.5
		$Spawner.start()
		$BalaoFalando.start()

func _on_TempoParado_timeout():
	var s = randi() % 2
	if s:	scale.x = scale.x
	else:	scale.x*=-1
	estado = "Andando"

func Infectar():
	infectado = true
	$IconeInfectado.visible = true
