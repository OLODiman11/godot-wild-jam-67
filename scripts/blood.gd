extends Node2D

@onready var sprite_2d:Sprite2D = $Sprite2D

func _ready():
	$Sprite2D.frame = randi_range(0, 4)


