extends Node2D

@onready var anim = $AnimationPlayer

func _ready():
	anim.play("cutscene_start")
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_packed(Scenes.GAME)
	


func _on_animation_player_animation_finished(_anim_name):
	get_tree().change_scene_to_packed(Scenes.GAME)
	
