class_name Health

extends Node2D

signal health_changed

@export var max_health: float:
	set(value):
		max_health = value
		health_changed.emit()

@onready var health := max_health:
	set(value):
		value = clampf(value, 0, max_health)
		health = value
		
		get_parent().sprite_2d.modulate = Color.RED + health / max_health * Color.AQUA
		
		health_changed.emit()

func take_damage(damage: float):
	health -= damage
	
func heal(amount: float):
	health += amount
	
func set_max_health(value: float):
	max_health = value
	
