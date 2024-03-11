extends Node2D

@onready var timer: Timer = $Enemy_spawn_cd

var round_num = 0
var wave_list = [5,10,15,20]
var preload_enemy = preload("res://scenes/enemy.tscn")
var enemy_count: int

func _ready():
	pass

func create_wave(enemies: int):
	enemy_count = enemies
	timer.start()
	
func _on_enemy_spawn_cd_timeout():
	
	var enemy = preload_enemy.instantiate()	
	
	enemy.global_position = _get_enemy_random_position()
	
	while enemy.global_position.x < -1750 or enemy.global_position.x > 1750 or enemy.global_position.y > 1750 or enemy.global_position.y < -1750:
		enemy.global_position = _get_enemy_random_position()
	
	add_child(enemy)
	enemy_count-=1
	
	if enemy_count <= 0:
		timer.stop()
		round_num += 1
		$Button.visible = true

func _get_enemy_random_position():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	$Player/Path2D/PathFollow2D.progress = rng.randi_range(0, 1600)
	return $Player/Path2D/PathFollow2D/Marker2D.global_position


func _on_button_pressed():
	$Button.visible = false
	create_wave(wave_list[round_num])


