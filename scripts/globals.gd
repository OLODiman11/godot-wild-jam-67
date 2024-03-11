extends Node

signal killed

var upgrade_points = 0

func enemy_killed():
	upgrade_points += 1
	emit_signal("killed")
