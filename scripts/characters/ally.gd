class_name Ally

extends CharacterBody2D

func _ready():
	$"Health".max_health = PlayerStats.max_health
	$"Health".health = PlayerStats.max_health
	
	PlayerStats.max_health_changed.connect($Health.set_max_health)
	PlayerStats.speed_changed.connect($Movement.set_speed)
	PlayerStats.regen_rate_changed.connect($Regeneration.set_rate)
	
static func _on_enemy_killed(enemy: Enemy):
	var killed_by = enemy.last_shot_by
	var enemy_weapon = enemy.get_node("Weapon").weapon_res
	var enemy_weapon_index = Globals.weapon_resources.find(enemy_weapon)
	killed_by.get_node("Inventory").possessed_weapons[enemy_weapon_index] = true
	var current_weapon: WeaponRes = killed_by.get_node("Weapon").weapon_res
	var current_weapon_index = Globals.weapon_resources.find(current_weapon)
	if killed_by == PlayerController.instance.character:
		PlayerController.instance.update_inventory_ui()
	if PlayerController.instance.character != killed_by:
		if enemy_weapon_index > current_weapon_index:
			killed_by.get_node("Weapon").switch(enemy_weapon)
		
