extends RigidBody2D

func _process(delta):
	if Input.is_action_just_pressed('ui_accept'):
		jump()

func jump():
	linear_velocity = Vector2.ZERO
	apply_central_impulse(Vector2(0, -500))
