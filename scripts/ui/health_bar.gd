class_name HealthBar

extends TextureProgressBar

@export var health: Health : set = set_health_component

func update(sender: Health):
	value = health.value / health.max_value * max_value
	
func set_health_component(value: Health):
	if health:
		health.value_changed.disconnect(update)
		health.max_value_changed.disconnect(update)
		
	health = value
	health.value_changed.connect(update)
	health.max_value_changed.connect(update)
	
