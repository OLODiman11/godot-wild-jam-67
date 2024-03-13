extends Node2D

@export var ally_scene: Resource
@export var allies_container: Node2D

func convert_to_ally(enemy: Enemy):
	var ally: Ally = ally_scene.instantiate()
	ally.global_position = enemy.global_position
	ally.get_node("Weapon").weapon_res = enemy.get_node("Weapon").weapon_res
	ally.get_node("Sprite2D").texture = enemy.get_node("Sprite2D").texture
	enemy.queue_free()
	allies_container.add_child(ally)
