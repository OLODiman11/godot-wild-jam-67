class_name Bullet

extends CharacterBody2D

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
		queue_free()
	
	if collision != null:
		var collidee = collision.get_collider()
		if collidee.is_in_group('Map'):
			queue_free()
			return
		if collidee.is_in_group("Enemies"):
			var enemy: Enemy = collidee
			enemy.last_shot_by = shooter
		var health_node: Health = collidee.get_node_or_null("Health")
		if health_node != null:
			health_node.take_damage(damage)
			queue_free()

func set_collision_masks(masks:Array[int]):
	for mask in masks:
		set_collision_mask_value(mask, true)
