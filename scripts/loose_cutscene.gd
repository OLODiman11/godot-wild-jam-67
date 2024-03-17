extends Node2D

@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("loose_animation")
	
func open_menu():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
