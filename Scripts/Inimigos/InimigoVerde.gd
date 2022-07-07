extends KinematicBody2D

var gravidade = 300
var impulsoy = 0

var dano = false
var TempoPisca = 0

var pisca = 0

var velx = 3

var direcaox = 1


var Chao = Vector2(0,-1)


var vida = 5

var TempoMorte = 0

func _ready():
	pass


func _physics_process(delta):
	
	#DANO---------------------------
	
	if dano == true:
		TempoPisca += delta
	if TempoPisca > 1:
			dano = false
			TempoPisca = 0
		
	if dano == true and vida >= 0:
		pisca += delta
	if pisca > 0.25:
		pisca = 0
	if pisca < 0.125:
		show()
	else:
		hide()
	if dano == false:
		pisca = 0
	
	#DANO---------------------------
	
	#GRAVIDADE---------------------------------------------
	impulsoy += delta * 3
	if impulsoy > 1:
		impulsoy = 1
	
	
	move_and_slide(Vector2(0, gravidade * impulsoy), Chao)
	
	move_local_x(velx)
	if vida <= 0:
		velx = 0
		TempoMorte += delta
	if TempoMorte > 0.6:
		queue_free()


func _on_Detector_body_entered(body):
	scale.x = scale.x * -1
	pass # Replace with function body.


func _on_Shape_body_entered(body):
	if body.name == ("Perc"):
		
		body.dano = true
		if body.global_position > global_position:
			body.impulsox = 4
		if body.global_position < global_position:
			body.impulsox = -4
	pass # Replace with function body.
