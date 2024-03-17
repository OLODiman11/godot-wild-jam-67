extends Control

var has_been_shown = false

@onready var wave_manager = $"../../WaveManager"
@onready var upgrade_menu = $"../UI/UpgradeMenu"
@onready var next_wave = $"../UI/NextWave"
@onready var upgrade_button = $"../UI/UpgradeButton"

func _ready():
	visibility_changed.connect(_on_visability_changed)

func _input(event):
	if event.is_action_pressed("next_character"):
		hide()
	if event.is_action_pressed("menu"):
		hide()

func _on_visability_changed():
	if visible:
		Globals.hide_on_esc = true
	else:
		Globals.hide_on_esc = false

func show_once():
	if has_been_shown:
		return
	wave_manager.wave_ended.connect(show_delayed_shop)
	has_been_shown = true
	await get_tree().create_timer(1).timeout
	GameManager.instance.pause_game()
	show()
	
func reissue_wave_ended():
	wave_manager.wave_ended.emit()
	
func show_delayed_shop():
	await get_tree().create_timer(1).timeout
	upgrade_button.show()
	next_wave.show()
	upgrade_menu.show()
