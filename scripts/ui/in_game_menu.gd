extends Control


func _input(event):
	if Globals.hide_on_esc:
		return
	if event.is_action_pressed("menu"):
		visible = !visible
		if visible:
			GameManager.instance.pause_game()
		else:
			GameManager.instance.unpause_game()
