extends CanvasLayer

var telapause = preload("res://Scenes/GUI/TelaPause.tscn")

func _ready():
	
	pass

func _on_ButtonMenu_button_up():
	pausar()

func _input(event):
	if event.is_action_pressed("Menu"):
		pausar()

func pausar():
	var pause = telapause.instance()
	get_parent().add_child(pause)
	get_tree().paused = true
