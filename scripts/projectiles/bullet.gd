class_name Bullet

extends CharacterBody2D

@export var direction: Vector2:
	set(value):
		direction = value.normalized()
@export var speed: float
@export var damage: float
@export var fire_range: float
@export var orig_glob_pos: Vector2

func _physics_process(delta):
	var collision := move_and_collide(speed * direction * delta)
	
	if (orig_glob_pos - global_position).length_squared() > fire_range**2:
		queue_free()
	
	if collision != null:
		if collision.get_collider().is_in_group('Map'):
			queue_free()
			return
		var health_node: Health = collision.get_collider().get_node("Health")
		if health_node != null:
			health_node.take_damage(damage)
			queue_free()