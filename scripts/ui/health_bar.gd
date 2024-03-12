extends TextureProgressBar

@export var health: Health

@onready var timer: Timer = $Timer

func _ready():
	if health:
		health.health_changed.connect(update)
		value = health.health / health.max_health * max_value
	timer.timeout.connect(hide_bar)

func update():
	show_bar()
	value = health.health / health.max_health * max_value

func show_bar():
	timer.start()
	show()
	
func hide_bar():
	timer.stop()
	hide()
