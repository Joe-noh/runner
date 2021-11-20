extends KinematicBody2D

var velocity = Vector2(100, 0)

func init(pos, speed_ratio):
	self.position = pos
	velocity = velocity * speed_ratio

func _process(delta):
	position -= velocity * delta

	if position.x < -50:
		queue_free()
