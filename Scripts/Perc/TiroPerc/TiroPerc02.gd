extends Node2D

var Tempo = 0
var velx = 10
var direcaox = 1
var TempoMorte = 0
var ContaTempoMorte = false
func _ready():
	pass

func _physics_process(delta):
	Tempo +=delta
	
	if Tempo < 0.2:
		$AnimacaoTiro.play("TiroPerc")
	
	if Tempo > 0.2:
		$AnimacaoTiro.play("Tiro02Pronto")
	
	move_local_x(velx * direcaox)
	if Tempo > 3:
		queue_free()
	
	if ContaTempoMorte == true:
		TempoMorte += delta
	


func _on_Detector_body_entered(body):
	if body.is_in_group("Inimigo"):
		body.destruir()
		pass
	queue_free()
