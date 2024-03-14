class_name Character

extends CharacterBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var weapon: Weapon = $Weapon
@onready var movement: Movement = $Movement
@onready var ai_controller: AiController = $AiController
@onready var health_bar: HealthBar = $HealthBar
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var health: Health = $Health
