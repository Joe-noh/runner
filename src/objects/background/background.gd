extends Sprite

const VELOCITY = -200
onready var width = texture.get_width() * scale.x

func _process(delta):
	position.x += VELOCITY * delta

	if (position.x < -width):
		position.x += width * 2
