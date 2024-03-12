extends Node

signal points_changed(int)

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
