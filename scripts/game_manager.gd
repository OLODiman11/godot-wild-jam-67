class_name GameManager

extends Node

static var instance

func _ready():
	instance = self

func pause_game():
	if get_tree() != null:
		get_tree().paused = true
	
func unpause_game():
	if get_tree() != null:
		get_tree().paused = false
		
func disable_shoot():
	Globals.disabled_shoot = true
	
func enable_shoot():
	Globals.disabled_shoot = false
