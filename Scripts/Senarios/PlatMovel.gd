extends Node2D

var velx = 3
var direcaox = 1

var vely = 3
var direcaoy= 0

var personagem = false
var Perc = null
func _ready():
	pass


func _physics_process(delta):
	move_local_x(velx * direcaox)
	move_local_y(vely * direcaoy)
	#MOVE PERSONAGEM----------------------------------
	if Perc != null:
		if personagem == true:
			Perc.VelxPlat = velx*direcaox
	#MOVE PERSONAGEM----------------------------------



func _on_MudaDirecao_body_entered(body):
	velx = velx * -1
	pass # Replace with function body.





func _on_DetectorPerc_body_exited(body):
	if body.name == "Perc":
		body.VelxPlat = 0
		body.VelyPlat = 0
		Perc = null
	pass # Replace with function body.


func _on_Pisou_body_entered(body):
	if body.name == "Perc":
		personagem = true
		Perc = body
	pass # Replace with function body.
