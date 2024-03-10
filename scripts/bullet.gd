class_name Bullet

extends CharacterBody2D

@export var direction: Vector2:
	set(value):
		direction = value.normalized()
@export var speed: float
@export var damage: float

var initial_velocity: Vector2

func _physics_process(delta):
	var collision := move_and_collide((initial_velocity + speed * direction) * delta)
	if collision != null:
		if collision.get_collider().is_in_group('Enemies'):
			collision.get_collider().get_hit(damage)
			queue_free()
		elif collision.get_collider().is_in_group('Map'):
			queue_free()
