extends CharacterBody2D
class_name RangeWeapon

var speed: float = 300
var direction: Vector2

func _physics_process(_delta):
	velocity = direction * speed
	move_and_slide()

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(10)
	queue_free()
