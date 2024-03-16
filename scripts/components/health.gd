class_name Health

extends Node2D

signal health_changed
signal died(Node2D)

var blood_sprite = preload("res://scenes/blood.tscn")

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
		if is_equal_approx(0, health):
			var parent = get_parent()
			var blood = blood_sprite.instantiate()
			get_tree().root.get_node("Main/Map").add_child(blood)
			blood.position = parent.position
			parent.queue_free()
			died.emit(parent)

func take_damage(damage: float):
	health -= damage
	
func heal(amount: float):
	health += amount
	
func set_max_health(value: float):
	max_health = value
	
