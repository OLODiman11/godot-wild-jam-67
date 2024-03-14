class_name Character

extends CharacterBody2D

@onready var collision_shape_2d = $CollisionShape2D
@onready var sprite_2d = $Sprite2D
@onready var weapon = $Weapon
@onready var movement = $Movement
@onready var ai_controller = $AiController
@onready var health_bar = $HealthBar
@onready var animation_player = $AnimationPlayer
@onready var health = $Health
