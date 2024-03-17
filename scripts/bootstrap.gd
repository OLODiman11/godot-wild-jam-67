extends Node

@export var current_ally: Ally
@export var allies_container: Node2D 
@export var enemies_container: Node2D 

func _ready():
	Globals.upgrade_points = 0
	Globals.hide_on_esc = false
	Globals.mother_points = 0
	
	PlayerStats.max_health = 500
	PlayerStats.regen_rate = 1
	PlayerStats.speed = 800
	PlayerStats.max_parasite_count = 1
	
	PlayerController.instance.character = current_ally
	PlayerController.instance.allies_container = allies_container
	PlayerController.instance.enemies_container = enemies_container 
