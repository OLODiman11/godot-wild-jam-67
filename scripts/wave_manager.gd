class_name WaveManager

extends Node2D

signal wave_ended
signal wave_started

var MAP_BOUNDS := 1700

@onready var timer: Timer = $SpawnTimer
const WAVES_DIR: String = "res://resources/waves/"

@export var enemies_container: Node2D
@export var spawn_path: Path2D
@export var preload_enemy = preload("res://scenes/characters/enemy.tscn")

var round_num = 0

var _waves: Array[WaveCongif]
var _spawn_queue: Array[EnemyRes]

func _ready():
	var wave_file_names = DirAccess.get_files_at(WAVES_DIR)
	for file in wave_file_names:
		var abs_path = "%s%s" % [WAVES_DIR, file]
		_waves.append(load(abs_path))
	timer.timeout.connect(spawn_enemy)

func start_next_wave():
	var wave: WaveCongif = _waves[round_num]
	_populate_spawn_queue(wave)
	round_num += 1
	timer.start()
	wave_started.emit()
	
func spawn_enemy():
	if _spawn_queue.size() == 0:
		timer.stop()
		return
	
	var enemy: Enemy = preload_enemy.instantiate()
	
	enemy.enemy_res = _spawn_queue.pop_back()
	
	enemy.get_node("Health").died.connect(func(_x): try_end_wave())
	enemy.get_node("Health").died.connect(Ally._on_enemy_killed)
	enemy.converted_to_parasite.connect(try_end_wave)
	
	while true:
		enemy.global_position = _get_enemy_random_position()
		var is_in_bounds_x: bool = abs(enemy.global_position.x) <= MAP_BOUNDS
		var is_in_bounds_y: bool = abs(enemy.global_position.y) <= MAP_BOUNDS
		if is_in_bounds_x and is_in_bounds_y:
			break
			
	enemies_container.add_child(enemy)
		
func try_end_wave():
	if _spawn_queue.size() > 0:
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
	
func _populate_spawn_queue(wave: WaveCongif):
	_spawn_queue.clear()
	for i in range(wave.enemies.size()):
		var enemy_res = wave.enemies[i]
		var amount = wave.amounts[i]
		var batch: Array[EnemyRes] = []
		batch.resize(amount)
		batch.fill(enemy_res)
		_spawn_queue.append_array(batch)
	_spawn_queue.shuffle()
