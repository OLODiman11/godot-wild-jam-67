extends Node

signal max_health_changed(float)
signal speed_changed(float)
signal regen_rate_changed(float)
signal max_parasite_count_changed(int)

var max_health: float = 500:
	set(value):
		max_health = value
		max_health_changed.emit(max_health)

var regen_rate: float = 1:
	set(value):
		regen_rate = value
		regen_rate_changed.emit(regen_rate)

var speed: float = 800:
	set(value):
		speed = value
		speed_changed.emit(speed)
		
var max_parasite_count: int = 10:
	set(value):
		max_parasite_count = value
		max_parasite_count_changed.emit(max_parasite_count)
	
func add_speed(amount: float):
	speed += amount
	
func add_max_health(amount: float):
	max_health += amount
	
func add_regen_rate(amount: float):
	regen_rate += amount
	
func add_max_parasite_count(amount: float):
	max_parasite_count += amount
