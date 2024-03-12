extends Node

signal max_health_changed(float)
signal stamina_changed(float)
signal speed_changed(float)
signal regen_rate_changed(float)

var max_health: float = 100:
	set(value):
		max_health = value
		max_health_changed.emit(max_health)

var regen_rate: float = 1:
	set(value):
		regen_rate = value
		regen_rate_changed.emit(regen_rate)
		
var stamina: float = 10:
	set(value):
		stamina = value
		stamina_changed.emit(stamina)

var speed: float = 800:
	set(value):
		speed = value
		speed_changed.emit(speed)
		
func add_speed(amount: float):
	speed += amount
	
func add_max_health(amount: float):
	max_health += amount
	
func add_regen_rate(amount: float):
	regen_rate += amount
	
func add_stamina(amount: float):
	stamina += amount
