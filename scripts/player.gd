class_name Player

extends CharacterBody2D

signal healthChanged

@export var speed: float
@export var run_speed: float
@export var max_health := 100.0
@export var regen_rate := 2.0
@export var stamina := 50.0

@onready var regen_timer = $RegenTimer
@onready var animation_player = $AnimationPlayer


var health := max_health:
	set(value):
		health = value
		$Sprite2D.modulate = Color.RED + health / max_health * Color.WHITE
		if health <= 0:
			get_tree().change_scene_to_file("res://scenes/main.tscn")

func switch_weapon(weapon_path: String):
	$Weapon.weapon_res = load(weapon_path)

func _process(_delta):
	$Weapon.look_at(get_global_mouse_position())
	if health >= max_health:
		regen_timer.stop()
	
	if Input.is_action_pressed("shoot"):
		$Weapon.shoot([Layers.ENEMIES])

func _physics_process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction:
		animation_player.play("parasite_walk")
	else:
		animation_player.play("parasite_idle")
	
	if direction.x < 0:
		$Sprite2D.flip_h = false
	else: 
		$Sprite2D.flip_h = true
	
	velocity = direction * speed
	
	if Input.is_action_pressed("run"):
		velocity = run_speed * direction
		
	move_and_slide()
	
func get_hit(damage: float):
	health -= damage
	if health < max_health and health + regen_rate <= max_health:
		regen_timer.start()
	healthChanged.emit()


func _on_regen_timer_timeout():
	health += regen_rate
	if health > max_health:
		health = max_health
	healthChanged.emit()
