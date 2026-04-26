extends Area2D

#@export var speed: float = 80.0
#var timer: float = 0.0
#var touching = []
#
#@onready var sprite = $Sprite2D
#
#func _ready() -> void:
	#sprite.position = Vector2(0, 0)
	#body_entered.connect(_on_body_entered)
	#body_exited.connect(_on_body_exited)
	#if has_node("Health"):
		#get_node("Health").died.connect(queue_free)
#
#func _physics_process(delta: float) -> void:
	#var targets = get_tree().get_nodes_in_group("player") + get_tree().get_nodes_in_group("crystal")
	#var target = targets.reduce(func(a, b): return a if global_position.distance_to(a.global_position) < global_position.distance_to(b.global_position) else b) if targets else null
#
	#if target:
		#global_position += global_position.direction_to(target.global_position) * speed * get_physics_process_delta_time()
#
	#if touching:
		#timer += delta
		#if timer >= 1.5:
			#timer = 0.0
			#for body in touching:
				#var health = _get_health(body)
				#if health:
					#health.take_damage(1)
#
#func _get_health(body: Node) -> Node:
	#if body.has_node("Health"):
		#return body.get_node("Health")
	#if body.get_parent() and body.get_parent().has_node("Health"):
		#return body.get_parent().get_node("Health")
	#return null
#
#func _on_body_entered(body: Node) -> void:
	#if body.is_in_group("player") or body.is_in_group("crystal_body"):
		#touching.append(body)
#
#func _on_body_exited(body: Node) -> void:
	#touching.erase(body)
