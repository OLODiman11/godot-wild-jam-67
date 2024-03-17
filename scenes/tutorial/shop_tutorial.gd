extends Control

var has_been_shown = false

func _input(event):
	if event.is_action_pressed("next_character"):
		hide()

func show_once():
	if has_been_shown:
		return
	has_been_shown = true
	await get_tree().create_timer(0.2).timeout
	show()
