class_name Enemy

extends CharacterBody2D

signal died
signal healthChanged

@onready var animation_player = $AnimationPlayer

@onready var enemy_res: EnemyRes:
	set(value):
		enemy_res = value
		$Weapon.weapon_res = enemy_res.weapon_res

var player: Player
@onready var health := enemy_res.max_health:
	set(value):
		health = value
		$Sprite2D.modulate = Color.RED + health / enemy_res.max_health * Color.WHITE
		if health <= 0:
			queue_free()
			Globals.enemy_killed()
			died.emit()

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	$Sprite2D.texture = enemy_res.sprite

func _physics_process(delta):
	$Weapon.look_at(player.global_position)
	
	var sqr_dist = (global_position - player.global_position).length_squared()
	if sqr_dist < $Weapon.weapon_res.fire_range**2:
		$Weapon.shoot([Layers.PLAYER])
		animation_player.play("enemy_idle")
	else:
		var direction = (player.position - position).normalized()
		if direction.x < 0:
			$Sprite2D.flip_h = false
		else: 
			$Sprite2D.flip_h = true
		velocity = direction * enemy_res.speed * delta
		animation_player.play("enemy_walk")
		move_and_collide(velocity)
	

func get_hit(damage: float):
	health -= damage
	healthChanged.emit()
