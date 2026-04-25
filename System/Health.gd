extends Node
class_name Health
@export var max_nb_hearts: int = 3
var curr_nb_hearts: int

signal died
signal health_changed(newValue)

func _ready() -> void:
	curr_nb_hearts = max_nb_hearts

func take_damage(amount: int):
	curr_nb_hearts -= amount
	health_changed.emit(curr_nb_hearts)

	if curr_nb_hearts <=0 :
		die()

func die():
	died.emit()
