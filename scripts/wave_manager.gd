class_name WaveManager

extends Node2D

signal wave_ended

var MAP_BOUNDS := 1700

@onready var timer: Timer = $SpawnTimer

@export var enemies_container: Node2D
@export var spawn_path: Path2D
@export var wave_list: PackedInt32Array = [5,10,15,20]
@export var preload_enemy = preload("res://scenes/characters/enemy.tscn")

var round_num = 0
var _enemies_to_spawn: int

func _ready():
	timer.timeout.connect(spawn_enemy)

func start_next_wave():
	_enemies_to_spawn = wave_list[round_num]
	round_num += 1
	timer.start()
	
func spawn_enemy():
	if _enemies_to_spawn == 0:
		timer.stop()
		return
	
	_enemies_to_spawn -= 1
	
	var enemy: Enemy = preload_enemy.instantiate()
	enemies_container.add_child(enemy)
	if randi_range(0, 4) == 0:
		enemy.enemy_res = load("res://resources/enemies/guard.tres")
	else:
		enemy.enemy_res = load("res://resources/enemies/melee.tres")
	enemy.died.connect(func(_x): try_end_wave())
	enemy.died.connect(Ally._on_enemy_killed)
	enemy.converted_to_parasite.connect(try_end_wave)
	
	while true:
		enemy.global_position = _get_enemy_random_position()
		var is_in_bounds_x: bool = abs(enemy.global_position.x) <= MAP_BOUNDS
		var is_in_bounds_y: bool = abs(enemy.global_position.y) <= MAP_BOUNDS
		if is_in_bounds_x and is_in_bounds_y:
			break
	
		
func try_end_wave():
	if _enemies_to_spawn > 0:
		return
		
	for enemy in enemies_container.get_children():
		if !enemy.is_queued_for_deletion():
			return
	wave_ended.emit()
		

func _get_enemy_random_position():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var path_follow = spawn_path.get_node("PathFollow2D")
	path_follow.progress = rng.randi_range(0, 1600)
	return path_follow.get_node("Marker2D").global_position
