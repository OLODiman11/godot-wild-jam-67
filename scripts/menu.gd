extends Control

@onready var play_button = $VBoxContainer/PlayButton
@onready var settings_button = $VBoxContainer/Settings

func _ready():
	play_button.grab_focus()
	play_button.pressed.connect(_on_play_button_pressed)
	play_button.pressed.connect(UiSfxPlayer.background_music_player.stop)
	settings_button.pressed.connect(_on_settings_button_pressed)

func _on_play_button_pressed():
	get_tree().change_scene_to_packed(Scenes.CUTSCENE)
	
func _on_settings_button_pressed():
	get_tree().change_scene_to_packed(Scenes.MENU_SETTINGS)
