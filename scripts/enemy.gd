extends CharacterBody2D

@onready var player = $"../Player"

@export var max_health := 100.0
@export var speed: float

var health := max_health:
	set(value):
		health = value
		$Sprite2D.modulate = Color.RED + health / max_health * Color.WHITE
		if health <= 0:
			queue_free()


func _physics_process(delta):
	var direction = (player.position - position).normalized()
	velocity = direction * speed * delta
	var collision = move_and_collide(velocity)
	if collision != null:
		if collision.get_collider().is_in_group('Player'):
			player.get_hit(1)
	

func get_hit(damage: float):
	health -= damage
