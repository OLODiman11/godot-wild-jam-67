extends Node2D

signal character_switched(CharacterBody2D)

@export var character: CharacterBody2D:
	set(value):
		if _ai_controller != null:
			_ai_controller.enabled = true
			
		if _health != null:
			_health.died.disconnect(switch_character)
			
		character = value
		_movement = character.get_node("Movement")
		_weapon = character.get_node("Weapon")
		_ai_controller = character.get_node("AiController")
		_ai_controller.enabled = false
		_health = character.get_node("Health")
		_health.died.connect(switch_character)
		
		character_switched.emit(character)

var _movement: Movement
var _weapon: Weapon
var _ai_controller: AiController
var _health: Health
var _parasite: Resource = preload("res://scenes/projectiles/parasite.tscn")
var parasites_released: int = 0:
	set(value):
		parasites_released = value
		print(parasites_released)

@onready var allies_container = get_tree().root.get_node("Main/AlliesContainer")
@onready var enemies_container = get_tree().root.get_node("Main/EnemiesContainer")

func _input(event):
	if allies_container:
		if allies_container.get_child_count() + parasites_released < PlayerStats.max_parasite_count:
			if event.is_action_pressed("release_parasite"):
				parasites_released += 1
				var parasite: Parasite = _parasite.instantiate()
				parasite.missed.connect(func(): parasites_released -= 1)
				parasite.hit.connect(func(): parasites_released -= 1)
				var weapon: Weapon = character.get_node("Weapon")
				parasite.position = weapon.global_position
				parasite.orig_glob_pos = weapon.global_position
				parasite.direction = weapon.get_global_transform().x
				for mask in weapon.bullet_collision_mask:
					parasite.set_collision_mask_value(mask, true)
				var root_node = get_tree().root.get_node('Main')
				root_node.add_child(parasite)
			
		if event.is_action_pressed("next_character"):
			switch_character()
	
func switch_character():
	var size = allies_container.get_children().size()
	var all_dead = true
	for child in allies_container.get_children():
		if !child.is_queued_for_deletion():
			all_dead = false
	if all_dead:
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	for i in range(size):
		var is_current_caharacter = allies_container.get_child(i) == character
		print(is_current_caharacter)
		if is_current_caharacter:
			var new_character = allies_container.get_child((i + 1) % size)
			var camera = character.get_node("MainCamera")
			var path = character.get_node("SpawnPath")
			character.remove_child(camera)
			new_character.add_child(camera)
			character.remove_child(path)
			new_character.add_child(path)
			character = new_character
			break

func _physics_process(_delta: float):
	if _weapon:
		_weapon.look_at(get_global_mouse_position())
		if get_global_mouse_position() > character.global_position:
			character.get_node("Sprite2D").flip_h = true
		else:
			character.get_node("Sprite2D").flip_h = false
		

		if Input.is_action_pressed("shoot"):
			_weapon.shoot()
		
		var direction = Input.get_vector("left", "right", "up", "down")
		if direction:
			character.get_node("AnimationPlayer").play("walk")
		else:
			character.get_node("AnimationPlayer").play("idle")
		if Input.is_action_pressed("run"):
			_movement.run(direction)
		else:
			_movement.move(direction)
