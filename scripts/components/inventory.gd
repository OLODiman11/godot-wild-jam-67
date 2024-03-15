class_name Inventory

extends Node2D

@export var possessed_weapons: Array[bool] = get_false_array()

func get_false_array() -> Array[bool]:
	var array: Array[bool] = []
	var weapons_count = Globals.weapon_resources.size()
	array.resize(weapons_count)
	array.fill(false)
	return array
