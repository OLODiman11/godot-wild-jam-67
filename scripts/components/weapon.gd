class_name Weapon

extends Node2D

const BATON: WeaponRes = preload("res://resources/weapons/baton.tres")
const PISTOL: WeaponRes = preload("res://resources/weapons/pistol.tres")
const RIFLE: WeaponRes = preload("res://resources/weapons/rifle.tres")
const GENADE_LAUNCHER: WeaponRes = preload("res://resources/weapons/grenade_launcher.tres")
const SNIPER_RIFLE: WeaponRes = preload("res://resources/weapons/sniper_rifle.tres")

@export var bullet_collision_mask: Array[Globals.Layers]
@export var bullet_scene: Resource
@export var weapon_res: WeaponRes:
	set(value):
		weapon_res = value
		_shoot_timer = 1
		if _current_player.playing:
			var old_player = _current_player
			old_player.finished.connect(func(): old_player.queue_free())
			var new_player = AudioStreamPlayer2D.new()
			add_child(new_player)
			_current_player = new_player
		_current_player.stream = weapon_res.shoot_sound

var _shoot_timer: float = 0
@export var _current_player: AudioStreamPlayer2D

func _ready():
	$ShootPoint.position = weapon_res.shoot_point_offset * Vector2.RIGHT
	
func _process(delta: float):
	_shoot_timer = clampf(_shoot_timer + delta, -INF, 1)
	
func switch(new_weapon_res: WeaponRes):
	weapon_res = new_weapon_res
	
func shoot():
	if _shoot_timer < 0:
		return
	
	_shoot_timer = -1.0 / weapon_res.fire_rate
	
	_current_player.pitch_scale = randf_range(0.99, 1.01)
	_current_player.volume_db = randf_range(-0.5, 0.5)
	_current_player.play()
	
	if weapon_res.is_melee:
		var forward := get_global_transform().x
		var end := global_position + weapon_res.fire_range * forward
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create(global_position, end)
		var result = space_state.intersect_ray(query)
		if result:
			if result.collider.is_in_group("Enemies"):
				var enemy: Enemy = result.collider
				enemy.last_shot_by = get_parent()
			var health_node: Health = result.collider.get_node_or_null("Health")
			if health_node != null:
				health_node.take_damage(weapon_res.damage)
	else:
		var bullet = weapon_res.projectile.instantiate()
		var root_node = get_tree().root.get_node('Main')
		root_node.add_child(bullet)
		bullet.speed = weapon_res.bullet_speed
		bullet.damage = weapon_res.damage
		bullet.position = $ShootPoint.global_position
		bullet.fire_range = weapon_res.fire_range
		bullet.orig_glob_pos = global_position
		bullet.direction = get_global_transform().x
		bullet.shooter = get_parent()
		bullet.set_collision_masks(bullet_collision_mask)
