extends Control

func _ready():
	visibility_changed.connect(_on_visability_changed)

func _input(event):
	if event.is_action_pressed("next_character"):
		hide()
	if event.is_action_pressed("menu"):
		hide()
		
func _on_visability_changed():
	if visible:
		Globals.hide_on_esc = true
	else:
		Globals.hide_on_esc = false
