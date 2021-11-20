extends Node2D

var elapsed = 0
var spawned = 0
var rng = RandomNumberGenerator.new()

onready var Bird = load("res://src/objects/bird/bird.tscn")

func _ready():
	rng.randomize()

func _process(delta):
	elapsed += (10 + spawned * 0.1) * delta

	if elapsed > 10:
		var bird = Bird.instance()
		var y = rng.randi_range(10, 760)
		bird.init(Vector2(1300, y), 2.0)

		add_child(bird)

		spawned += 1
		elapsed = 0
