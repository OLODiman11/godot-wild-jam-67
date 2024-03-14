class_name Enemy

extends CharacterBody2D

signal converted_to_parasite

@onready var movement = $Movement
@onready var health = $Health
@onready var weapon = $Weapon
@onready var sprite_2d = $Sprite2D

var last_shot_by: Node2D
var enemy_res: EnemyRes:
	set(value):
		enemy_res = value
		movement.speed = enemy_res.speed
		health.max_health = enemy_res.max_health
		health.health = enemy_res.max_health
		weapon.switch(enemy_res.weapon_res)
		sprite_2d.texture = enemy_res.sprite

func _ready():
	health.died.connect(func(_x): Globals.enemy_killed())
