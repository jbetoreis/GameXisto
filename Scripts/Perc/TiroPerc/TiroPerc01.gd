extends Node2D

var Tempo = 0

func _ready():
	pass

func _physics_process(delta):
	Tempo +=delta
	
	$AnimacaoTiro.play("TiroPerc01")
	
	if Tempo > 0.3:
		queue_free()


func _on_Detector_body_entered(body):
	if body.is_in_group("Inimigo"):
		body.destruir()
		pass
