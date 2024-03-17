class_name CustomButton

extends Button

func _ready():
	mouse_entered.connect(UiSfxPlayer.button_hover_player.play)
	focus_entered.connect(UiSfxPlayer.button_hover_player.play)
	pressed.connect(UiSfxPlayer.button_press_player.play)

