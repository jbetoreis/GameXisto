extends Node2D

var NaArea = false
var tempo = 0

func _ready():
	pass


func _physics_process(delta):
	
	if NaArea == true:
		tempo += delta
	if tempo > 3:
		$Animacao.play("EspinhoDescendo")
	if tempo > 3 and tempo < 5:
		$Animacao.play("Abaixado")
	
	if tempo > 5 and tempo < 5.5:
		$Animacao.play("EspinhoLevantado")
	
	if tempo > 5.5:
		$Animacao.play("EspinhoLevantado")
		tempo = 0
	


func _on_DetectorPerc_body_entered(body):
	body.dano = true
	if body.global_position > global_position:
		body.impulsox = 4
	if body.global_position < global_position:
		body.impulsox = -4
	pass # Replace with function body.


func _on_DetectorArea_body_entered(body):
	NaArea = true
	$Animacao.play("EspinhoLevantando")
	pass # Replace with function body.


func _on_DetectorArea_body_exited(body):
	NaArea = false
	$Animacao.play("EspinhoDescendo")
	tempo = 0
	pass # Replace with function body.
