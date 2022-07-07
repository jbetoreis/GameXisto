extends Sprite

onready var PosicaoFixar = get_parent().get_node("PosicaoBraco")

func _ready():
	
	pass

func _process(delta):
	position = PosicaoFixar.position
	pass
