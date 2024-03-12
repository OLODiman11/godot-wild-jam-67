extends PanelContainer

@onready var health: LabeledValue = $UpgradeList/Health
@onready var speed: LabeledValue = $UpgradeList/Speed
@onready var stamina: LabeledValue = $UpgradeList/Stamina
@onready var regen_rate: LabeledValue = $UpgradeList/RegenRate

func _ready():
	health.increment_button.pressed.connect(PlayerStats.add_max_health.bind(5))
	speed.increment_button.pressed.connect(PlayerStats.add_speed.bind(10))
	stamina.increment_button.pressed.connect(PlayerStats.add_stamina.bind(2))
	regen_rate.increment_button.pressed.connect(PlayerStats.add_regen_rate.bind(1))
	
	for item in $UpgradeList.get_children():
		item.increment_button.pressed.connect(Globals.spend_points.bind(1))
	
	PlayerStats.max_health_changed.connect(health.value.set_text)
	PlayerStats.speed_changed.connect(speed.value.set_text)
	PlayerStats.stamina_changed.connect(stamina.value.set_text)
	PlayerStats.regen_rate_changed.connect(regen_rate.value.set_text)
			
	Globals.points_changed.connect(check_points)

func check_points(points: int):
	if points <= 0:
		health.increment_button.disabled = true
		speed.increment_button.disabled = true
		stamina.increment_button.disabled = true
		regen_rate.increment_button.disabled = true
	else:
		health.increment_button.disabled = false
		speed.increment_button.disabled = false
		stamina.increment_button.disabled = false
		regen_rate.increment_button.disabled = false
