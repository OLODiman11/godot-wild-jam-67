class_name Player

extends CharacterBody2D

@export var speed: float
@export var run_speed: float
@export var max_health := 100.0

var health := max_health:
	set(value):
		health = value
		$Sprite2D.modulate = Color.RED + health / max_health * Color.WHITE
		if health <= 0:
			get_tree().change_scene_to_file("res://scenes/main.tscn")

func switch_weapon(weapon_path: String):
	$Weapon.weapon_res = load(weapon_path)

func _process(delta):
	$Weapon.look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("shoot"):
		$Weapon.shoot([Layers.ENEMIES])

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	
	if Input.is_action_pressed("run"):
		velocity = run_speed * direction
	
	move_and_slide()
	
func get_hit(damage: float):
	health -= damage
	
