extends Node
class_name Health

@export var max_health: int = 3
var current_health: int

signal died
signal health_changed(newValue)

func _ready() -> void:
	current_health = max_health

func take_damage(amount: int):
	current_health -= amount
	health_changed.emit(current_health)

	if current_health <= 0:
		die()

func die():
	died.emit()
