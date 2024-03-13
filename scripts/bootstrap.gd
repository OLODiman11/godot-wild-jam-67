extends Node

@export var current_ally: Ally

func _ready():
	PlayerController.character = current_ally
