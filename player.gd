extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -600.0
const WALL_JUMP_PUSH = 400.0

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle ground jump AND wall jump
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif is_on_wall():
			velocity.y = JUMP_VELOCITY
			# get_wall_normal().x returns 1 if the wall is on the left, or -1 if on the right
			velocity.x = get_wall_normal().x * WALL_JUMP_PUSH

	# Handle left/right movement
	var direction := Input.get_axis("left", "right")
	if direction:
		# Smoothly accelerate so wall-jump push isn't instantly cancelled
		velocity.x = move_toward(velocity.x, direction * SPEED, 30.0)
	else:
		# Slow down faster on the ground than in the air
		var friction = SPEED if is_on_floor() else 15.0
		velocity.x = move_toward(velocity.x, 0, friction)

	move_and_slide()
	

#func _on_collision_shape_2d_child_entered_tree(node: Node) -> void:
	#var currentX = get_position_delta().x
	#var currentY = get_platform_velocity().y
	
	#velocity.x = -0.75 * velocity.x
	#move_and_slide()


func _on_collision_shape_2d_2_child_entered_tree(node: Node) -> void:
	pass # Replace with function body.
	
func _on_pickup_area_area_entered(area):
	if area.is_in_group("areaxyz"):
		get_tree().change_scene_to_file("res://level2.tscn")

func _on_area_2d_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
