@tool

class_name Weapon

extends Node2D

@export var type: Constants.WeaponType: set = set_type
@export var target_layers: Array[Globals.Layers]
@export_group("From Resource")
@export var is_melee: bool: get = get_is_melee
@export var damage: float: get = get_damage
@export var fire_rate: float: get = get_fire_rate
@export var fire_range: float: get = get_fire_range
@export var bullet_speed: float: get = get_bullet_speed
@export var bullet_spawn_offset: float: get = get_bullet_spawn_offset
@export var bullet_scene: PackedScene: get = get_bullet_scene
@export_group("")

var _weapon_res: WeaponRes

@onready var _shoot_point: Marker2D = $ShootPoint

var _fire_rate_timer: float = 0

func _ready():
	_set_bullet_spawn_offset()
	
func _process(delta: float):
	_fire_rate_timer = clampf(_fire_rate_timer + delta, -INF, 1)
	
func shoot():
	if _fire_rate_timer < 0:
		return
	
	_fire_rate_timer = -1.0 / fire_rate
	
	if is_melee:
		_attack_melee()
	else:
		_spawn_bullet()
	
func set_type(new_type: Constants.WeaponType):
	type = new_type
	_weapon_res = Resources.WEAPON_RES[type]
	notify_property_list_changed()
	if _cache_is_initialized():
		_set_bullet_spawn_offset()
	
func get_is_melee() -> bool:
	return _weapon_res.is_melee
	
func get_damage() -> float:
	return _weapon_res.damage
	
func get_fire_rate() -> float:
	return _weapon_res.fire_rate
	
func get_fire_range() -> float:
	return _weapon_res.fire_range
	
func get_bullet_speed() -> float:
	return _weapon_res.bullet_speed
	
func get_bullet_spawn_offset() -> float:
	return _weapon_res.bullet_spawn_offset
	
func get_bullet_scene() -> PackedScene:
	return _weapon_res.bullet_scene
	
func _cache_is_initialized() -> bool:
	return _shoot_point != null

func _set_bullet_spawn_offset():
	_shoot_point.position = bullet_spawn_offset * Vector2.RIGHT
	
func _spawn_bullet():
	var bullet = bullet_scene.instantiate()
	var root_node = get_tree().root.get_node('Main')
	root_node.add_child(bullet)
	bullet.speed = bullet_speed
	bullet.damage = damage
	bullet.position = _shoot_point.global_position
	bullet.fire_range = fire_range
	bullet.orig_glob_pos = global_position
	bullet.direction = get_global_transform().x
	bullet.shooter = get_parent()
	for layer in target_layers:
		bullet.set_collision_mask_value(layer, true)
	
func _attack_melee():
	var hit_char = _raycast_forward()
	if hit_char:
		hit_char.last_shot_by = get_parent()
		hit_char.health.value -= damage
	
func _raycast_forward() -> Character:
	var forward: Vector2 = get_global_transform().x
	var ray_start: Vector2 = global_position
	var ray_end: Vector2 = ray_start + fire_range * forward
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(ray_start, ray_end)
	var result = space_state.intersect_ray(query)
	if result && (result.collider is Character):
		return result.collider
	return null
	
func _validate_property(property):
	var range_specific_vars = ["bullet_scene", "bullet_spawn_offset", "bullet_speed"]
	if property.name in range_specific_vars:
		if is_melee:
			property.usage = PROPERTY_USAGE_NONE
		else:
			property.usage = PROPERTY_USAGE_STORAGE | PROPERTY_USAGE_EDITOR
	
