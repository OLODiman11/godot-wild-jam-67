class_name Enemy

extends CharacterBody2D

signal converted_to_parasite

var enemy_res: EnemyRes:
	set(value):
		enemy_res = value
		$Movement.speed = enemy_res.speed
		$Health.max_health = enemy_res.max_health
		$Weapon.switch(enemy_res.weapon_res)

func _ready():
	PlayerController.character_switched.connect(switch_target)
	$Health.died.connect(Globals.enemy_killed)
	
func switch_target(new_target: CharacterBody2D):
	$AiController.target = new_target
