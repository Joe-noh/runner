extends KinematicBody2D

var _velocity = Vector2(100, 0)

func init(pos, speed_ratio):
	self.position = pos
	_velocity = _velocity * speed_ratio

func _process(delta):
	self.position -= _velocity * delta

func _on_screen_exited():
	queue_free()
