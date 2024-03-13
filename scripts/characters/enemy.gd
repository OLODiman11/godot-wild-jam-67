class_name Enemy

extends CharacterBody2D

signal converted_to_parasite

var enemy_res: EnemyRes:
	set(value):
		enemy_res = value
		$Movement.speed = enemy_res.speed
		$Health.max_health = enemy_res.max_health
		$Weapon.switch(enemy_res.weapon_res)
		$Sprite2D.texture = enemy_res.sprite

func _ready():
	$Health.died.connect(Globals.enemy_killed)
