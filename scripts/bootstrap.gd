extends Node

@export var current_ally: Ally
@export var allies_container: Node2D 
@export var enemies_container: Node2D 

func _ready():
	PlayerController.instance.character = current_ally
	PlayerController.instance.allies_container = allies_container
	PlayerController.instance.enemies_container = enemies_container 
