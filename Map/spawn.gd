extends Node2D
 
#@export var enemy_scene: PackedScene
#@export var spawn_interval: float = 3.0
#var timer: float = 0.0
 #
#func _process(delta: float) -> void:
	#if enemy_scene == null:
		#return
	#timer += delta
	#if timer >= spawn_interval:
		#timer = 0.0
		#var enemy = enemy_scene.instantiate()
		#enemy.global_position = global_position
		## Spawner is inside Room which is inside game_scene
		## get_parent() = Room, get_parent().get_parent() = game_scene
		#get_tree().current_scene.add_child(enemy)
		#
