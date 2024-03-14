@tool

class_name Health

extends Node2D

signal value_changed(sender: Health)
signal max_value_changed(sender: Health)
signal fraction_changed(sender: Health)

@export var value: float: get = get_value, set = set_value
@export var max_value: float: get = get_max_value, set = set_max_value
@export var fraction: float: get = get_fraction, set = set_fraction

var _value: float = 100
var _max_value: float = 100

func get_value() -> float:
	return _value

func set_value(new_value: float):
	new_value = clampf(new_value, 0, max_value)
	if is_equal_approx(value, new_value): 
		return
	_set_and_emit_all(new_value, max_value)

func get_max_value() -> float:
	return _max_value

func set_max_value(new_max_value: float):
	if is_equal_approx(max_value, new_max_value): 
		return
	_set_and_emit_all(value, new_max_value)
	
func get_fraction() -> float:
	return value / max_value
	
func set_fraction(new_fraction: float):
	new_fraction = clampf(new_fraction, 0, 1)
	if is_equal_approx(fraction, new_fraction):
		return
	var new_value = new_fraction * max_value
	_set_and_emit_all(new_value, max_value)
	
func _set_and_emit_all(new_value: float, new_max_value: float):
	var prev_value = value
	var prev_max_value = max_value
	var prev_fraction = fraction
	
	_max_value = new_max_value
	_value = clampf(new_value, 0, new_max_value)
	
	if !is_equal_approx(value, prev_value):
		value_changed.emit(self) 
	if !is_equal_approx(max_value, prev_max_value):
		max_value_changed.emit(self)
	if !is_equal_approx(fraction, prev_fraction):
		fraction_changed.emit(self) 
