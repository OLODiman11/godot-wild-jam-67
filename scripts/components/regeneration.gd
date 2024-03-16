class_name Regeneration

extends Node2D

@export var rate: float:
	set = set_rate
@export var amount: float
@export var health: Health

@onready var timer = $Timer

func _ready():
	timer.wait_time = 1.0 / rate
	timer.timeout.connect(heal)
	$Timer.wait_time = 1.0 / rate
	
func heal():
	health.value += amount
	
func set_rate(value: float):
	rate = value
