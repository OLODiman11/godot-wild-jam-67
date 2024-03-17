class_name Movement

extends Node2D


@onready var animation_player = $"../AnimationPlayer"

@export var speed: float
@export var run_speed: float

@onready var _parent: CharacterBody2D = get_parent()

func move(direction: Vector2):
	direction = direction.normalized()
	_parent.velocity = direction * speed
	_parent.move_and_slide()
	
	
func set_speed(value: float):
	speed = value
