extends CharacterBody2D

@export var speed: float
@export var run_speed: float

func switch_weapon(weapon_path: String):
	$Weapon.weapon_res = load(weapon_path)

func _process(delta: float):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("right"):
		direction += Vector2.RIGHT
	if Input.is_action_pressed("left"):
		direction += Vector2.LEFT
	if Input.is_action_pressed("down"):
		direction += Vector2.DOWN
	if Input.is_action_pressed("up"):
		direction += Vector2.UP
				
	direction = direction.normalized()
	var velocity = speed * direction
	if Input.is_action_pressed("run"):
		velocity = run_speed * direction
	
	self.position += velocity * delta
	
