extends Node2D
class_name CursorWeapon

@export var projectile_scene: PackedScene

func shoot(origin: Vector2):
	var projectile = projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)

	projectile.global_position = origin

	var mouse_pos = get_global_mouse_position()
	var dir = (mouse_pos - origin).normalized()

	projectile.direction = dir
	projectile.rotation = dir.angle()
