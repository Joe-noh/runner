extends Sprite

const VELOCITY = -200
onready var _width = texture.get_width() * scale.x

func _process(delta):
	self.position.x += VELOCITY * delta

	if (self.position.x < -_width):
		self.position.x += _width * 2
