class_name Ally

extends Character

@onready var inventory: Inventory = $Inventory
@onready var regeneration: Regeneration = $Regeneration

func _ready():
	super._ready()
	PlayerStats.max_health_changed.connect(func(x): health.max_health = x)
	PlayerStats.speed_changed.connect(movement.set_speed)
	PlayerStats.regen_rate_changed.connect(regeneration.set_rate)
	
static func _on_enemy_killed(enemy: Enemy):
	var killed_by = enemy.last_shot_by
	var enemy_weapon = enemy.weapon.weapon_res
	var enemy_weapon_index = Globals.weapon_resources.find(enemy_weapon)
	killed_by.inventory.possessed_weapons[enemy_weapon_index] = true
	var current_weapon: WeaponRes = killed_by.weapon.weapon_res
	var current_weapon_index = Globals.weapon_resources.find(current_weapon)
	if killed_by == PlayerController.character:
		PlayerController.update_inventory_ui()
	if enemy_weapon_index > current_weapon_index:
		killed_by.weapon.switch(enemy_weapon)
