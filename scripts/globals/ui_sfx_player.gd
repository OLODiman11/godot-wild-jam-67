extends Node

var button_hover_player: AudioStreamPlayer
var button_press_player: AudioStreamPlayer
var background_music_player: AudioStreamPlayer

func _ready():
	button_hover_player = AudioStreamPlayer.new()
	button_press_player = AudioStreamPlayer.new()
	background_music_player = AudioStreamPlayer.new()
	
	add_child(button_hover_player)
	add_child(button_press_player)
	add_child(background_music_player)
	
	button_hover_player.stream = load("res://assets/sounds/ui/hover.ogg")
	button_press_player.stream = load("res://assets/sounds/ui/press.ogg")
	background_music_player.stream = load("res://assets/sounds/menu_background.mp3")

	background_music_player.play()
