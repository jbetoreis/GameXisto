extends KinematicBody2D

var movimento = Vector2()
var speed = 300
var decair = false
var colidi = false
var xx = 0
var yy = 0

func _ready():
	randomize()
	pass

func _physics_process(delta):
	rotation_degrees+=0.5
	move_and_slide(movimento)
	if !colidi:
		movimento.y+=0.0085*300
	if position.x<-550 or position.x>7900 or position.y<-50 or position.y>1000:
		queue_free()
func _on_Area2D_body_entered(body):
	if !body.is_in_group("Exclusao"):
		movimento = Vector2(0,0)
		colidi = true
	if body.name == ("Perc"):
		if !Global.pauseDialog:
			body.dano = true
			if body.global_position > global_position:
				body.impulsox = 4
			if body.global_position < global_position:
				body.impulsox = -4

func destruir():
	$AnimationPlayer.play("Sumir")
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
	
func escolher(Lista):
	return Lista[randi() % Lista.size()]

func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	if !area.is_in_group("Exclusao"):
		movimento = Vector2(0,0)
		colidi = true
	if area.is_in_group("Pedestre"):
		var chance = rand_range(0,10)
		if area.Mascarado:
			if chance>2:
				area.Infectar()
		else:
			if chance>0.5:
				area.Infectar()

func _on_TempoDeVida_timeout():
	destruir()

func Direcao(escala, xxx01, xxx02, yyy01, yyy02):
	randomize();
	xx = escolher([xxx01*sign(escala), xxx02*sign(escala)])
	yy = escolher([yyy01, 0, yyy02])
	movimento = Vector2(xx,yy)*speed

func _setSpeed(spd):
	speed = spd

func intangivel():
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	$Shape.disabled = true
	$TempoIntangivel.start()

func _on_TempoIntangivel_timeout():
	$Area2D/CollisionShape2D.set_deferred("disabled", false)
	$Shape.disabled = false

