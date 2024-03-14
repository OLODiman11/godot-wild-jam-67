class_name HealthBar

extends TextureProgressBar

@export var health: Health

@onready var timer: Timer = $Timer

func _ready():
	if health:
		health.value_changed.connect(func(_x): update())
		health.max_value_changed.connect(func(_x): update())
		value = health.value / health.max_value * max_value
	timer.timeout.connect(hide_bar)

func update():
	show_bar()
	value = health.value / health.max_value * max_value

func show_bar():
	timer.start()
	show()
	
func hide_bar():
	timer.stop()
	hide()
