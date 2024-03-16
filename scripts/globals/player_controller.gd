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
		_inventory = character.get_node("Inventory")
		
		update_inventory_ui()
			
		character_switched.emit(character)

var current_weapon_index = 1
var _movement: Movement
var _weapon: Weapon
var _ai_controller: AiController
var _health: Health
var _inventory: Inventory
var _parasite: Resource = preload("res://scenes/projectiles/parasite.tscn")
var parasites_released: int = 0:
	set(value):
		parasites_released = value
		print(parasites_released)

@onready var allies_container = get_tree().root.get_node("Main/AlliesContainer")
@onready var enemies_container = get_tree().root.get_node("Main/EnemiesContainer")

func _input(event):
	if event.is_action_pressed("release_parasite"):
		if allies_container.get_child_count() + parasites_released < PlayerStats.max_parasite_count:
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
		
	if event.is_action_pressed("first_weapon"):
		switch_weapon(0)
	if event.is_action_pressed("second_weapon"):
		switch_weapon(1)
	if event.is_action_pressed("third_weapon"):
		switch_weapon(2)
	if event.is_action_pressed("fourth_weapon"):
		switch_weapon(3)
	
func switch_weapon(index):
	if !_inventory.possessed_weapons[index]:
		return
	
	var container = get_tree().root.get_node("Main/CanvasLayer/UI/Inventory/PanelContainer/MarginContainer/HFlowContainer")
	var previous = container.get_child(current_weapon_index)
	previous.get_child(1).hide()
	
	current_weapon_index = index
	var child = container.get_child(index)
	child.get_child(1).show()
	
	_weapon.weapon_res = Globals.weapon_resources[index]
	
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
			var index = Globals.weapon_resources.find(new_character.get_node("Weapon").weapon_res)
			new_character.get_node("Inventory").possessed_weapons[index] = true
			character = new_character
			switch_weapon(index)
			break

func _physics_process(_delta: float):
	if character:
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

		
func update_inventory_ui():
	var container = get_tree().root.get_node("Main/CanvasLayer/UI/Inventory/PanelContainer/MarginContainer/HFlowContainer")
	for i in range(Globals.weapon_resources.size()):
		if _inventory.possessed_weapons[i]:
			container.get_child(i).get_child(2).show()
		else:
			container.get_child(i).get_child(2).hide()
		

