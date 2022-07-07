extends Node2D


func _ready():
	$Animacao.play("Espalhar")

func _on_Animacao_animation_finished():
	queue_free()
