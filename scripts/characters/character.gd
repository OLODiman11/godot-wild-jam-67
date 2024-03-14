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
@onready var health_bar_timer: Timer = $HealthBar/Timer

func _ready():
	# Die logic
	health.value_changed.connect(_die_if_zero_health)
	
	# Sprite tint logic
	health.value_changed.connect(_change_sprite_tint)
	health.max_value_changed.connect(_change_sprite_tint)
	
	# Health bar show/hide logic
	health_bar_timer.timeout.connect(health_bar.hide)
	health.value_changed.connect(_show_health_bar_and_restart_timer)
	health.max_value_changed.connect(_show_health_bar_and_restart_timer)
	
func _die_if_zero_health(sender: Health):
	if health.value <= 0:
		queue_free()
		died.emit()
		EventBus.character_died.emit(self)
	
func _change_sprite_tint(sender: Health):
	var factor = health.value / health.max_value
	var tint = Color(1, factor, factor)
	sprite_2d.modulate = tint
	
func _show_health_bar_and_restart_timer():
	health_bar.show()
	health_bar_timer.start()
