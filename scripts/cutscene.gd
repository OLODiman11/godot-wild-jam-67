extends Node2D

@onready var anim = $AnimationPlayer


func _ready():
	anim.play("cutscene_start")
	


func _on_animation_player_animation_finished(_anim_name):
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	
