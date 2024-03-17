extends PanelContainer

@onready var health: LabeledValue = $UpgradeList/Health
@onready var speed: LabeledValue = $UpgradeList/Speed
@onready var regen_rate: LabeledValue = $UpgradeList/RegenRate
@onready var max_parasite_count: LabeledValue = $UpgradeList/MaxParasiteCount

func _ready():
	health.increment_button.pressed.connect(PlayerStats.add_max_health.bind(50))
	speed.increment_button.pressed.connect(PlayerStats.add_speed.bind(100))
	regen_rate.increment_button.pressed.connect(PlayerStats.add_regen_rate.bind(2))
	max_parasite_count.increment_button.pressed.connect(PlayerStats.add_max_parasite_count.bind(1))
	
	health.increment_button.pressed.connect(Globals.spend_points.bind(1))
	speed.increment_button.pressed.connect(Globals.spend_points.bind(1))
	regen_rate.increment_button.pressed.connect(Globals.spend_points.bind(2))
	max_parasite_count.increment_button.pressed.connect(Globals.spend_points.bind(5))
	
	PlayerStats.max_health_changed.connect(set_label_text.bind(health))
	PlayerStats.speed_changed.connect(set_label_text.bind(speed))
	PlayerStats.regen_rate_changed.connect(set_label_text.bind(regen_rate))
	PlayerStats.max_parasite_count_changed.connect(set_label_text.bind(max_parasite_count))
			
	Globals.points_changed.connect(check_points)

func check_points(points: int):
		health.increment_button.disabled = points < 2
		speed.increment_button.disabled = points < 1
		max_parasite_count.increment_button.disabled = points < 5
		regen_rate.increment_button.disabled = points < 3
		
func set_label_text(value: float, labeled_value: LabeledValue):
	labeled_value.value.set_text(str(value))
