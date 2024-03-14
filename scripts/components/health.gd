class_name Health

extends Node2D

signal health_changed
signal died(Node2D)

@export var max_health: float:
	set(value):
		max_health = value
		health_changed.emit()

@onready var health := max_health:
	set(value):
		value = clampf(value, 0, max_health)
		health = value
		get_parent().get_node("Sprite2D").modulate = Color.RED + health / max_health * Color.AQUA
		health_changed.emit()
		if health == 0:
			var parent = get_parent()
			parent.queue_free()
			died.emit(parent)

func take_damage(damage: float):
	health -= damage
	
func heal(amount: float):
	health += amount
	
func set_max_health(value: float):
	max_health = value
	
