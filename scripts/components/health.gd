class_name Health

extends Node2D

signal health_changed
signal died

@export var max_health: float:
	set(value):
		max_health = value
		health_changed.emit()

@onready var health := max_health:
	set(value):
		value = clampf(value, 0, max_health)
		health = value
		health_changed.emit()
		if health == 0:
			get_parent().queue_free()
			died.emit()

func take_damage(damage: float):
	health -= damage
	
func heal(amount: float):
	health += amount
	
func set_max_health(value: float):
	max_health = value
	
