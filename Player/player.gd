extends CharacterBody2D

@export var mov_speed: float = 125
@export var projectile_scene: PackedScene = preload("res://Weapon/RangeWeapon.tscn")

var char_direction: Vector2
var is_dead := false

@onready var cooldown: Timer = $ShootCooldown
@onready var health: Health = $Health
@onready var sprite: AnimatedSprite2D = %sprite

func _ready():
	cooldown.wait_time = 1
	cooldown.one_shot = true

func _physics_process(delta):
	if is_dead:
		return

	char_direction.x = Input.get_axis("move_left", "move_right")
	char_direction.y = Input.get_axis("move_up", "move_down")

	# flip sprite
	if char_direction.x > 0:
		sprite.flip_h = false
	elif char_direction.x < 0:
		sprite.flip_h = true

	# movement + animation
	if char_direction != Vector2.ZERO:
		velocity = velocity.move_toward(char_direction * mov_speed, 1000 * delta)

		# 🔥 force walking unless dead
		if sprite.animation != "walking" and sprite.animation != "dead":
			sprite.play("walking")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, mov_speed)

		if sprite.animation != "idle" and sprite.animation != "dead":
			sprite.play("idle")

	move_and_slide()


func _process(_delta):
	if is_dead:
		return

	if Input.is_action_pressed("shoot") and cooldown.is_stopped():
		shoot()
		cooldown.start()


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


func take_damage(amount: int, hit_pos: Vector2):
	if is_dead:
		return

	print("I GOT HIT:", amount)

	sprite.play("hurt")

	sprite.modulate = Color(1, 0, 0)

	var dir = (global_position - hit_pos).normalized()
	velocity = dir * 200

	health.take_damage(amount)

	if health.current_health <= 0:
		die()

	# reset color quickly
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = Color(0.219, 0.219, 0.219, 1.0)


func die():
	is_dead = true

	sprite.play("dead")

	# stop everything
	set_physics_process(false)
	set_process(false)

	# disable collision safely
	$CollisionShape2D.set_deferred("disabled", true)
