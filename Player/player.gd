extends CharacterBody2D

@export var mov_speed: float = 125
@export var projectile_scene: PackedScene = preload("res://Weapon/RangeWeapon.tscn")

var char_direction: Vector2

func _ready():
	cooldown.wait_time = 1
	cooldown.one_shot = true
	print(projectile_scene)

func _physics_process(_delta):
	char_direction.x = Input.get_axis("move_left", "move_right")
	char_direction.y = Input.get_axis("move_up", "move_down")

	if char_direction.x > 0:
		%sprite.flip_h = false
	elif char_direction.x < 0:
		%sprite.flip_h = true

	if char_direction != Vector2.ZERO:
		velocity = char_direction * mov_speed
		if %sprite.animation != "walking":
			%sprite.animation = "walking"
	else:
		velocity = velocity.move_toward(Vector2.ZERO, mov_speed)
		if %sprite.animation != "idle":
			%sprite.animation = "idle"

	move_and_slide()

func shoot():
	if projectile_scene == null:
		print("NO PROJECTILE SCENE")
		return

	var projectile = projectile_scene.instantiate()
	get_parent().add_child(projectile)

	var mouse_pos = get_global_mouse_position()
	var dir = (mouse_pos - global_position).normalized()

	projectile.global_position = global_position + dir * 20
	projectile.direction = dir
	projectile.rotation = dir.angle()
		
		
@onready var cooldown: Timer = $ShootCooldown

func _process(_delta):
	if Input.is_action_pressed("shoot"):
		print("Pressed")

	if Input.is_action_pressed("shoot") and cooldown and cooldown.is_stopped():
		print("SHOOT")
		shoot()
		cooldown.start()
		
