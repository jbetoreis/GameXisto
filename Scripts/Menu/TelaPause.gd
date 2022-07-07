extends CanvasLayer


func _ready():
	
	pass

func _on_Pause_button_up():
	despausar()

func _on_Recarregar_button_up():
	get_tree().paused = false
	var itens = get_tree().get_nodes_in_group("GUI")
	for i in range(get_tree().get_nodes_in_group("GUI").size()):
		itens[i].queue_free()
	Global.primeiroJogo = true
	get_tree().reload_current_scene()
	queue_free()

func despausar():
	get_tree().paused = false
	queue_free()
