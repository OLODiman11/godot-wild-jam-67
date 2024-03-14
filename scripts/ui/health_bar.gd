@tool

class_name HealthBar

extends TextureProgressBar

@export var health: Health : set = set_health_component

func _adjust(sender: Health):
	self.value = health.fraction * self.max_value
	
func set_health_component(value: Health):
	if health != null:
		health.fraction_changed.disconnect(_adjust)
		
	health = value
	health.fraction_changed.connect(_adjust)
	_adjust(health)
