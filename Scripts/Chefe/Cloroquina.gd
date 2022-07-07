extends Area2D

var speed = 8
var movimento = Vector2()

func _ready():
	pass
	

func _process(delta):
	position+=movimento*speed
	

func Parametros(dir, angulo):
	movimento = dir
	rotation_degrees = angulo


func _on_Cloroquina_body_entered(body):
	if body.name == ("Perc"):
		body.dano = true
		if body.global_position > global_position:
			body.impulsox = 4
		if body.global_position < global_position:
			body.impulsox = -4
		queue_free()
	if body.is_in_group("Chao"):
		queue_free()
