extends PanelContainer

@onready var player = $"../../.."


func _ready():
	Globals.killed.connect(update_points)
	$UpgradeList/Health/Upgrade/Number.text = str(player.max_health)
	$UpgradeList/Speed/Upgrade/Number.text = str(player.speed)
	$UpgradeList/Stamina/Upgrade/Number.text = str(player.stamina)
	$UpgradeList/RegenRate/Upgrade/Number.text = str(player.regen_rate)


func update_points():
	$"../UpgradePoints".text = "Points: %d" % Globals.upgrade_points

func check_points():
	if Globals.upgrade_points <= 0:
		$UpgradeList/Health/Upgrade/PlusHP.disabled = false
		$UpgradeList/Speed/Upgrade/PlusSpeed.disabled = false
		$UpgradeList/Stamina/Upgrade/PlusStamina.disabled = false
		$UpgradeList/RegenRate/Upgrade/PlusRegen.disabled = false

func _on_upgrade_button_pressed():
	$".".visible = true
	$"../UpgradeButton".visible = false
	if Globals.upgrade_points > 0:
		$UpgradeList/Health/Upgrade/PlusHP.disabled = false
		$UpgradeList/Speed/Upgrade/PlusSpeed.disabled = false
		$UpgradeList/Stamina/Upgrade/PlusStamina.disabled = false
		$UpgradeList/RegenRate/Upgrade/PlusRegen.disabled = false


func _on_close_button_pressed():
	$"../UpgradeButton".visible = true
	$".".visible = false
	
	
func _on_plus_regen_pressed():
	if Globals.upgrade_points <= 0:
		return
	player.regen_rate += 1
	Globals.upgrade_points -= 1
	$UpgradeList/RegenRate/Upgrade/Number.text = str(player.regen_rate)
	update_points()
	check_points()
	
	
func _on_plus_hp_pressed():
	if Globals.upgrade_points <= 0:
		return
	player.max_health += 5
	Globals.upgrade_points -= 1
	$UpgradeList/Health/Upgrade/Number.text = str(player.max_health)
	update_points()
	check_points()


func _on_plus_stamina_pressed():
	if Globals.upgrade_points <= 0:
		return
	player.stamina += 2
	Globals.upgrade_points -= 1
	$UpgradeList/Stamina/Upgrade/Number.text = str(player.stamina)
	update_points()
	check_points()


func _on_plus_speed_pressed():
	if Globals.upgrade_points <= 0:
		return
	player.speed += 10
	Globals.upgrade_points -= 1
	$UpgradeList/Speed/Upgrade/Number.text = str(player.speed)
	update_points()
	check_points()
