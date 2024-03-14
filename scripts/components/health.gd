class_name Health

extends Node2D

signal health_changed(sender: Health)
signal max_health_changed(sender: Health)

@export var max_health: float:
	set(value):
		max_health = value
		max_health_changed.emit(self)

@onready var health := max_health:
	set(value):
		value = clampf(value, 0, max_health)
		health = value
		health_changed.emit(self)

func take_damage(damage: float):
	health -= damage
	
func heal(amount: float):
	health += amount
	
func set_max_health(value: float):
	max_health = value
	
