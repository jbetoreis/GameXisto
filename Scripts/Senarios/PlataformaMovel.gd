extends Node2D

var VelPlataforma = 3
var Direcaox = 1

var perc = null

func _ready():
	pass


func _physics_process(delta):
	
	if perc != null:
		perc.velplatax = VelPlataforma * Direcaox
	
	move_local_x(VelPlataforma*Direcaox)
	

func _on_MudaDirecao_body_entered(body):
	Direcaox = Direcaox * -1
	pass # Replace with function body.


func _on_PercEntra_body_entered(body):
	if body.name == "Perc":
		perc = body
		
	pass # Replace with function body.




func _on_PercSai_body_exited(body):
	if body.name == "Perc":
		body.velplatax = 0
		perc = null
	pass # Replace with function body.
