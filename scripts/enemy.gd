extends Node

@export var max_health := 100.0

var health := max_health:
	set(value):
		health = value
		$Sprite2D.modulate = Color.RED + health / max_health * Color.WHITE
		if health <= 0:
			queue_free()

func get_hit(damage: float):
	health -= damage
