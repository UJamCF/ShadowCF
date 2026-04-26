extends Area2D

var speed: float = 45
var direction: Vector2

func _process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(1, global_position)
	queue_free()
