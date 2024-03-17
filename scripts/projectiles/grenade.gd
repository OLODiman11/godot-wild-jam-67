class_name Grenade

extends CharacterBody2D

@onready var area: Area2D = $Area2D


@export var direction: Vector2:
	set(value):
		direction = value.normalized()
@export var speed: float
@export var damage: float
@export var fire_range: float
@export var orig_glob_pos: Vector2

var shooter: Node2D

func _physics_process(delta):
	var collision := move_and_collide(speed * direction * delta)
	
	if (orig_glob_pos - global_position).length_squared() > fire_range**2:
		_blast()
		return
	
	if collision != null:
		if collision.get_collider().is_in_group('Map'):
			_blast()
			return
		if collision.get_collider().is_in_group("Enemies"):
			var enemy: Enemy = collision.get_collider()
			enemy.last_shot_by = shooter
		var health_node: Health = collision.get_collider().get_node("Health")
		if health_node:
			_blast()
			
			
func _blast():
	$Sprite2D2.visible = true
	$Sprite2D.visible = false
	create_tween().tween_property($Sprite2D2,"scale", Vector2(10,10), 0.2)
	await get_tree().create_timer(0.2).timeout
	for body in area.get_overlapping_bodies():
		if body.is_in_group("Enemies"):
			body.last_shot_by = shooter
		var health = body.get_node("Health")
		if health:
			health.take_damage(damage)
	queue_free()

func set_collision_masks(masks:Array[int]):
	for mask in masks:
		set_collision_mask_value(mask, true)
		area.set_collision_mask_value(mask, true)
	
