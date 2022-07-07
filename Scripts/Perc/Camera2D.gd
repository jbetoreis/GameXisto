extends Camera2D

var forca = 5
var duracao = 0.3
var xx = 0
var yy = 0
var tremor = false

func _ready():
	randomize()

func _process(delta):
	if tremor:
		xx = rand_range(-forca, forca)
		yy = rand_range(-forca, forca)
		offset.x = xx
		offset.y = yy
		forca*=0.8

func _on_TempoTremor_timeout():
	offset.x = 0
	offset.y = 0
	tremor = false

func Terremoto():
	tremor = true
	get_parent().get_node("TempoTremor").wait_time = duracao
	get_parent().get_node("TempoTremor").start()

func setParametros(forc, tempo):
	forca = forc
	duracao = tempo
