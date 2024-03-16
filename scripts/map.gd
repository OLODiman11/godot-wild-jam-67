extends Node2D

@onready var sirens = $Node2D
@onready var timer = $Node2D/Timer

const MAX_ENERGY: float = .5
const TIME_GAP: float = 0.05

var light := false

func _on_timer_timeout():
	for siren in sirens.get_children():	
		if siren != timer:
			if siren.energy < 0:
				light = false
			elif siren.energy > MAX_ENERGY:
				light = true
				
			if light:
				siren.energy -= TIME_GAP
			else:
				siren.energy += TIME_GAP
		
	
