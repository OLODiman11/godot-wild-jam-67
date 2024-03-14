class_name Enemy

extends Character

signal converted_to_parasite

var last_shot_by: Node2D
var enemy_res: EnemyRes:
	set(value):
		enemy_res = value
		movement.speed = enemy_res.speed
		health.max_value = enemy_res.max_health
		health.value = enemy_res.max_health
		weapon.switch(enemy_res.weapon_res)
		sprite_2d.texture = enemy_res.sprite

func _ready():
	super._ready()
	self.died.connect(func(_x): Globals.enemy_killed())
