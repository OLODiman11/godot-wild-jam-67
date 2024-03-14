extends Node

@export var current_ally: Ally
@export var allies_container: Node2D 
@export var enemies_container: Node2D 

func _ready():
	PlayerController.character = current_ally
	PlayerController.allies_container = allies_container
	PlayerController.enemies_container = enemies_container 
