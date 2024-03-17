class_name CustomButton

extends Button

func _ready():
	mouse_entered.connect(_on_mouse_entered)
	focus_entered.connect(_on_focus_entered)
	pressed.connect(_on_pressed)
	
func _on_mouse_entered():
	if !disabled:
		UiSfxPlayer.button_hover_player.play()

func _on_focus_entered():
	if !disabled:
		UiSfxPlayer.button_hover_player.play()
	
func _on_pressed():
	if !disabled:
		UiSfxPlayer.button_press_player.play()
