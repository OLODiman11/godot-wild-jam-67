extends Control

@onready var inventory = $"../UI/Inventory"

func _ready():
	Globals.character_died.connect(show_once)
	visibility_changed.connect(_on_visability_changed)
	
func _on_visability_changed():
	if visible:
		Globals.hide_on_esc = true
	else:
		Globals.hide_on_esc = false
	
func show_once(_x):
	Globals.character_died.disconnect(show_once)
	await get_tree().create_timer(1).timeout
	GameManager.instance.pause_game()
	show()
	inventory.show()
	
func _input(event):
	if event.is_action_pressed("next_character"):
		hide()
	if event.is_action_pressed("menu"):
		hide()
