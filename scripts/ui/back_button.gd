extends Button

func _on_pressed():
	get_tree().change_scene_to_packed(Scenes.MAIN_MENU)
