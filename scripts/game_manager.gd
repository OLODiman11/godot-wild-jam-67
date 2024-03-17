class_name GameManager

extends Node

static var instance

func _ready():
	instance = self

func pause_game():
	get_tree().paused = true
	
func unpause_game():
	get_tree().paused = false
