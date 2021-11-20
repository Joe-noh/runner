extends RigidBody2D

func _ready():
	self.contact_monitor = true
	self.contacts_reported = true

func _process(delta):
	if Input.is_action_just_pressed('ui_accept'):
		if !GameState.is_game_over:
			jump()

func jump():
	linear_velocity = Vector2.ZERO
	apply_central_impulse(Vector2(0, -500))

func _on_Runner_body_entered(body):
	if body.name == 'Bird':
		GameState.game_over()
