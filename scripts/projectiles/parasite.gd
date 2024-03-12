class_name Parasite

extends CharacterBody2D

signal missed

@export var speed: float
@export var fire_range: float
@export var direction: Vector2
@export var orig_glob_pos: Vector2

func _physics_process(delta):
	var collision := move_and_collide(speed * direction * delta)
	
	if (orig_glob_pos - global_position).length_squared() > fire_range**2:
		missed.emit()
		queue_free()
	
	if collision != null:
		if collision.get_collider().is_in_group('Map'):
			missed.emit()
			queue_free()
			return
		var enemy: Enemy = collision.get_collider()
		if enemy != null:
			get_node("/root/Main/AllyFactory").convert_to_ally(enemy)
			enemy.converted_to_parasite.emit()
			queue_free()
