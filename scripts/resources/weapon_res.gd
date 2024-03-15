@tool

class_name WeaponRes

extends Resource

@export var is_melee: bool: set = set_is_melee
@export var damage: float
@export var fire_rate: float
@export var fire_range: float
@export var bullet_speed: float
@export var bullet_spawn_offset: float
@export var bullet_scene: PackedScene

func set_is_melee(value: bool):
	is_melee = value
	notify_property_list_changed()

func _validate_property(property):
	var range_specific_vars = ["bullet_scene", "bullet_spawn_offset", "bullet_speed"]
	if property.name in range_specific_vars:
		if is_melee:
			property.usage = PROPERTY_USAGE_NONE
		else:
			property.usage = PROPERTY_USAGE_STORAGE | PROPERTY_USAGE_EDITOR
