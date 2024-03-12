class_name AiController

extends Node2D

@export var character: CharacterBody2D = get_parent()
@export var target: CharacterBody2D
@export var enabled: bool = true

@onready var _weapon: Weapon = get_parent().get_node("Weapon")
@onready var _movement: Movement = get_parent().get_node("Movement")

func _physics_process(_delta):
	if !enabled:
		return
		
	if target == null:
		var enemiesContainer = get_tree().root.get_node('Main/EnemiesContainer')
		if enemiesContainer.get_child_count() == 0:
			return
		var closiest = enemiesContainer.get_child(0)
		var min_distance = (closiest.global_position - get_parent().global_position).length()
		for enemy in enemiesContainer.get_children():
			var vector = enemy.global_position - get_parent().global_position
			var distance = vector.length()
			if distance < min_distance:
				closiest = enemy
				min_distance = distance
		
		target = closiest
			
		return
	
	_weapon.look_at(target.global_position)
	
	
	var vector_to_target = target.global_position - global_position
	if vector_to_target.x > 0:
		character.get_node("Sprite2D").flip_h = true
	else:
		character.get_node("Sprite2D").flip_h = false
	var dist_to_target = vector_to_target.length()
	var is_in_attack_range = dist_to_target < _weapon.weapon_res.fire_range
	if is_in_attack_range:
		_weapon.shoot()
		character.get_node("AnimationPlayer").play("ai_idle")
	else:
		_movement.move(vector_to_target)
		character.get_node("AnimationPlayer").play("ai_walk")
