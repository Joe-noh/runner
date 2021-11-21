extends Sprite

const VELOCITY = -200
onready var _width = texture.get_width() * scale.x

func _process(delta):
	position.x += VELOCITY * delta

	if (position.x < -_width):
		position.x += _width * 2
