extends Label

func _ready():
	Globals.points_changed.connect(update_label)
	
func update_label(points: int):
	text = "Points: %d" % points
