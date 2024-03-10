class_name Enemy

extends CharacterBody2D

signal died

@export var max_health := 100.0
@export var speed: float

var player: Player
var health := max_health:
	set(value):
		health = value
		$Sprite2D.modulate = Color.RED + health / max_health * Color.WHITE
		if health <= 0:
			queue_free()
			died.emit()

func _ready():
	player = get_tree().get_first_node_in_group("Player")

func _physics_process(delta):
	var direction = (player.position - position).normalized()
	velocity = direction * speed * delta
	var collision = move_and_collide(velocity)
	if collision != null:
		if collision.get_collider().is_in_group('Player'):
			player.get_hit(1)
	

func get_hit(damage: float):
	health -= damage
