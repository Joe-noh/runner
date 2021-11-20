extends RigidBody2D

func _process(delta):
	if Input.is_action_just_pressed('ui_up'):
		jump()

func jump():
	apply_central_impulse(Vector2(0, -500))
