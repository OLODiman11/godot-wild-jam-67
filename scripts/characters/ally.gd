class_name Ally

extends CharacterBody2D

func _ready():
	$"Health".max_health = PlayerStats.max_health
	$"Health".health = PlayerStats.max_health
	
	PlayerStats.max_health_changed.connect($Health.set_max_health)
	PlayerStats.speed_changed.connect($Movement.set_speed)
	PlayerStats.regen_rate_changed.connect($Regeneration.set_rate)
