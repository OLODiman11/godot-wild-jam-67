class_name AiController

extends Node2D

@export var enabled: bool = true
@export var character: Character
@export_enum(Groups.ALLIES, Groups.ENEMIES) var target_group: String

var _target: Character

func _physics_process(_delta):
	if !enabled:
		return
	
	_target = _get_closest_target()
	if _target == null:
		return
		
	_point_weapon_at_target()
	if _target_is_in_fire_range():
		_shoot()
	else:
		_move_towards_target()
		
func _get_closest_target() -> Character:
	var targets: Array[Node] = get_tree().get_nodes_in_group(target_group)
	var closest = null
	var min_distance = INF
	for target in targets:
		var distance = (target.global_position - character.global_position).length()
		if distance < min_distance:
			closest = target
			min_distance = distance
	return closest

func _point_weapon_at_target():
	character.weapon.look_at(_target.global_position)
	var dir_to_target = character.global_position.direction_to(_target.global_position)
	character.sprite_2d.flip_h = dir_to_target.x > 0
	
func _target_is_in_fire_range() -> bool:
	var dist_to_target = character.global_position.distance_to(_target.global_position)
	return dist_to_target < character.weapon.weapon_res.fire_range
	
func _shoot():
	character.weapon.shoot()
	character.animation_player.play(Animations.IDLE)
	
func _move_towards_target():
	var direction = character.global_position.direction_to(_target.global_position)
	character.movement.move(direction)
	character.animation_player.play(Animations.WALK)
