class_name Weapon

extends Node2D

@export var weapon_res: WeaponRes
@export var bullet_scene: Resource

var _shoot_timer: float = 0

func _ready():
	$ShootPoint.position = weapon_res.shoot_point_offset * Vector2.RIGHT
	
func _process(delta: float):
	look_at(get_global_mouse_position())
	
	_shoot_timer = clampf(_shoot_timer + delta, -INF, 1)
	if Input.is_action_pressed("shoot"):
		if _shoot_timer >= 0:
			_shoot_timer = -1.0 / weapon_res.fire_rate
			shoot()
	
func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.speed = weapon_res.bullet_speed
	bullet.damage = weapon_res.damage
	bullet.position = $ShootPoint.global_position
	bullet.direction = get_global_mouse_position() - self.global_position
	get_parent().get_parent().add_child(bullet)
