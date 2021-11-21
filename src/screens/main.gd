extends Node2D

var elapsed = 0
var spawned = 0
var rng = RandomNumberGenerator.new()

onready var Bird = load("res://src/objects/bird/bird.tscn")

func _ready():
	rng.randomize()

	$Restart.hide()
	$Restart.connect('clicked', self, '_on_restart_clicked')

	$Runner.connect('killed', self, '_on_runner_killed')

func _process(delta):
	elapsed += (10 + spawned * 0.1) * delta

	if elapsed > 10:
		var bird = Bird.instance()
		var y = rng.randi_range(10, 760)
		bird.init(Vector2(1300, y), 2.0)
		bird.add_to_group('birds')

		add_child(bird)

		spawned += 1
		elapsed = 0

func _on_restart_clicked():
	if GameState.is_game_over:
		$Restart.hide()
		GameState.restart()
		get_tree().reload_current_scene()

func _on_runner_killed():
	GameState.game_over()
	$Restart.show()
