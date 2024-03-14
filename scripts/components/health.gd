@tool

class_name Health

extends Node2D

signal value_changed(sender: Health)
signal max_value_changed(sender: Health)
signal fraction_changed(sender: Health)

@export var value: float = 100: set = set_value
@export var max_value: float = 100: set = set_max_value
@export var fraction: float: get = get_fraction

func set_max_value(new_value: float):
	if max_value == new_value: 
		return
		
	max_value = new_value
	max_value_changed.emit(self)
	fraction_changed.emit(self)
	
func set_value(new_value: float):
	if value == new_value: 
		return
	
	value = clampf(value, 0, max_value)
	value = new_value
	value_changed.emit(self)
	fraction_changed.emit(self)
	
func get_fraction() -> float:
	return value / max_value
