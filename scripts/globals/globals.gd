extends Node

signal points_changed(int)
signal game_won
signal character_died(CharacterBody2D)

const weapon_resources: Array[WeaponRes] = [
	preload("res://resources/weapons/baton.tres"),
	preload("res://resources/weapons/pistol.tres"),
	preload("res://resources/weapons/rifle.tres"),
	preload("res://resources/weapons/grenade_launcher.tres"),
	preload("res://resources/weapons/sniper_rifle.tres")
]

const waves = [
	preload("res://resources/waves/wave1.tres"),
	preload("res://resources/waves/wave2.tres"),
	preload("res://resources/waves/wave3.tres"),
	preload("res://resources/waves/wave4.tres"),
	preload("res://resources/waves/wave5.tres")
]

const POINTS_FOR_WIN: int = 100

var mother_points: int = 0:
	set(value):
		mother_points = value
		if mother_points >= POINTS_FOR_WIN:
			game_won.emit()
			get_tree().change_scene_to_packed(Scenes.WIN_CUTSCENE)
			print("You vonyaesh")

var upgrade_points: int = 0:
	set(value):
		upgrade_points = value
		points_changed.emit(upgrade_points)

func spend_points(amount: int):
	upgrade_points -= amount

func enemy_killed():
	upgrade_points += 1

enum Layers{
	General = 1,
	Allies = 2,
	Enemies = 3,
	Bullets = 4,
	Walls = 5
}
