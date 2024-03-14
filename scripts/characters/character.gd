class_name Character

extends CharacterBody2D

signal died

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var weapon: Weapon = $Weapon
@onready var movement: Movement = $Movement
@onready var ai_controller: AiController = $AiController
@onready var health_bar: HealthBar = $HealthBar
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var health: Health = $Health

func _ready():
	health.health_changed.connect(_die_if_zero_health)
	
func _die_if_zero_health():
	if health.health <= 0:
		queue_free()
		died.emit()
		EventBus.character_died.emit(self)
