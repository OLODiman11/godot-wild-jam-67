extends HBoxContainer

const LABEL_TEXT = "FEED YOUR MOTHER (%s/%s)"

@onready var progress_bar = $ProgressBar
@onready var plus_one = $PlusOne
@onready var plus_five = $PlusFive
@onready var plus_all = $PlusAll
@onready var label = $ProgressBar/Label

func _ready():
	plus_one.pressed.connect(_add_points.bind(1))
	plus_five.pressed.connect(_add_points.bind(5))
	plus_all.pressed.connect(_add_points.bind(-1))
	
	Globals.points_changed.connect(_set_disabled_according_to_points)
	
	_update_progress_bar()
	_set_disabled_according_to_points(Globals.upgrade_points)

func _add_points(amount: int):
	if amount == -1:
		amount = Globals.upgrade_points
	Globals.spend_points(amount)
	Globals.mother_points += amount
	_update_progress_bar()
	_set_disabled_according_to_points(Globals.upgrade_points)
	
func _update_progress_bar():
	progress_bar.value = Globals.mother_points
	label.text = LABEL_TEXT % [progress_bar.value, progress_bar.max_value]
	
func _set_disabled_according_to_points(points: int):
	plus_one.disabled = Globals.upgrade_points < 1
	plus_five.disabled = Globals.upgrade_points < 5
	plus_all.disabled = Globals.upgrade_points <= 0
