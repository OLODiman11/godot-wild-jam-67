class_name Weapon

extends Node2D

@export var weapon_res: WeaponRes:
	set(value):
		weapon_res = value
		_shoot_timer = 1
@export var bullet_scene: Resource

var _shoot_timer: float = 0

func _ready():
	$ShootPoint.position = weapon_res.shoot_point_offset * Vector2.RIGHT
	
func _process(delta: float):
	_shoot_timer = clampf(_shoot_timer + delta, -INF, 1)
	
func shoot(layers: PackedInt32Array):
	if _shoot_timer < 0:
		return
	
	_shoot_timer = -1.0 / weapon_res.fire_rate
	
	if weapon_res.is_melee:
		var forward := get_global_transform().x
		var end := global_position + weapon_res.fire_range * forward
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create(global_position, end)
		var result = space_state.intersect_ray(query)
		if result:
			if result.collider.is_in_group('Hittable'):
				result.collider.get_hit(weapon_res.damage)
	else:
		var bullet = bullet_scene.instantiate()
		bullet.speed = weapon_res.bullet_speed
		bullet.damage = weapon_res.damage
		bullet.position = $ShootPoint.global_position
		bullet.fire_range = weapon_res.fire_range
		bullet.orig_glob_pos = global_position
		bullet.direction = get_global_transform().x
		for layer in layers:
			bullet.set_collision_mask_value(layer, true)
		var root_node = get_tree().root.get_child(0)
		root_node.add_child(bullet)
