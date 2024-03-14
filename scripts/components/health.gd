@tool

class_name Health

extends Node2D

signal value_changed(sender: Health)
signal max_value_changed(sender: Health)

@export var value: float = 100: set = set_value
@export var max_value: float = 100: set = set_max_value

func set_max_value(new_value: float):
	max_value = new_value
	max_value_changed.emit(self)
	
func set_value(new_value: float):
	value = clampf(value, 0, max_value)
	value = new_value
	value_changed.emit(self)
