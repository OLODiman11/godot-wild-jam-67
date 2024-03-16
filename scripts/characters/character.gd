@tool

class_name Character

extends CharacterBody2D

signal died

@export var type: Constants.CharacterType = Constants.CharacterType.GUARD: 
	set = set_type
@export var infected: bool = true: set = set_infected

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
	_setup_dying_logic()
	_setup_sprite_tint_logic()
	_setup_health_bar()
	
func set_type(new_type: Constants.CharacterType):
	if !_cache_is_initialized():
		return
	type = new_type
	var char_res: EnemyRes = Resources.CHARACTER_RES[type]
	health.max_value = char_res.max_health
	movement.speed = char_res.speed
	weapon.type = char_res.weapon_type
	_set_sprite()
	
func set_infected(new_value: bool):
	if !_cache_is_initialized():
		return
	infected = new_value
	_set_sprite()

func _setup_dying_logic():
	health.value_changed.connect(_die_if_zero_health)
	
func _setup_sprite_tint_logic():
	health.fraction_changed.connect(_change_sprite_tint)
	
func _setup_health_bar():
	if !Engine.is_editor_hint():
		health_bar.hide()
		health_bar_timer.timeout.connect(health_bar.hide)
		health.fraction_changed.connect(_show_health_bar_and_restart_timer)
	health_bar.health = health
	
func _die_if_zero_health(_sender: Health):
	if health.value <= 0:
		queue_free()
		died.emit()
		EventBus.character_died.emit(self)
	
func _change_sprite_tint(_sender: Health):
	var tint = Color(1, health.fraction, health.fraction)
	sprite_2d.modulate = tint
	
func _show_health_bar_and_restart_timer(_sender: Health):
	health_bar.show()
	health_bar_timer.start()
	
func _cache_is_initialized() -> bool:
	return health != null
		
func _set_sprite():
	var char_res: EnemyRes = Resources.CHARACTER_RES[type]
	if infected:
		sprite_2d.texture = char_res.infected_sprites
	else:
		sprite_2d.texture = char_res.sprite
