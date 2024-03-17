extends Node

var button_hover_player: AudioStreamPlayer
var button_press_player: AudioStreamPlayer

func _ready():
	button_hover_player = AudioStreamPlayer.new()
	button_press_player = AudioStreamPlayer.new()
	
	add_child(button_hover_player)
	add_child(button_press_player)
	
	button_hover_player.stream = load("res://assets/sounds/ui/hover.ogg")
	button_press_player.stream = load("res://assets/sounds/ui/press.ogg")
