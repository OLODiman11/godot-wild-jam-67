class_name Ally

extends CharacterBody2D

func _ready():
	PlayerStats.max_health_changed.connect($Health.set_max_health)
	PlayerStats.speed_changed.connect($Movement.set_speed)
	PlayerStats.regen_rate_changed.connect($Regeneration.set_rate)
