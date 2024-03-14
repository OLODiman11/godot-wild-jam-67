class_name Health

extends Node2D

signal health_changed(sender: Health)
signal max_health_changed(sender: Health)

@export var health: float = 100: set = set_health
@export var max_health: float = 100: set = set_max_health

func set_max_health(value: float):
	max_health = value
	max_health_changed.emit(self)
	
func set_health(value: float):
	value = clampf(value, 0, max_health)
	health = value
	health_changed.emit(self)
