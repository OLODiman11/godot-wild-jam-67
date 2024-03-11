extends TextureProgressBar

@onready var enemy: Enemy = $".."
@onready var hide_hp = $HideHP

func _ready():
	enemy.healthChanged.connect(update)
	update()
	$".".visible = false

func update():
	hide_hp.start()
	value = enemy.health * 100 / 100
	$".".visible = true



func _on_hide_hp_timeout():
	$".".visible = false
	hide_hp.stop()
