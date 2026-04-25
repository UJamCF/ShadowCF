extends CharacterBody2D

@export var mov_speed:float = 125;


var char_direction : Vector2

func _physics_process(_delta):
	char_direction.x = Input.get_axis("move_left","move_right")    
	char_direction.y = Input.get_axis("move_up","move_down")    

	if char_direction.x > 0 :%sprite.flip_h = false
	elif char_direction.x < 0 :%sprite.flip_h = true


	if char_direction:
		velocity = char_direction * mov_speed
		if %sprite.animation != "walking": %sprite.animation = "walking"
	else:
		velocity = velocity.move_toward(Vector2.ZERO, mov_speed)
		if %sprite.animation != "idle": %sprite.animation = "idle" 
		
	move_and_slide()   
		
	
