extends Control

@onready var inventory = $"../UI/Inventory"

func _ready():
	Globals.character_died.connect(show_once)
	
func show_once(_x):
	Globals.character_died.disconnect(show_once)
	GameManager.instance.pause_game()
	show()
	inventory.show()
