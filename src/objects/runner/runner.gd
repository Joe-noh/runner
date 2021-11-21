extends RigidBody2D

signal killed

var _killed = false

func _ready():
	self.contact_monitor = true
	self.contacts_reported = true

	self.connect('body_entered', self, '_on_body_entered')

func _process(delta):
	if Input.is_action_just_pressed('ui_accept'):
		if not _killed:
			jump()

func jump():
	linear_velocity = Vector2.ZERO
	apply_central_impulse(Vector2(0, -500))

func _on_body_entered(body):
	if 'birds' in body.get_groups():
		_killed = true
		emit_signal('killed')
