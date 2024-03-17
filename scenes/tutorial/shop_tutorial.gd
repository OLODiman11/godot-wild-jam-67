extends Control

var has_been_shown = false

func show_once():
	if has_been_shown:
		return
	has_been_shown = true
	show()
